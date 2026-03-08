use strict;
use warnings FATAL => "all";

use FindBin;
use lib "$FindBin::Bin/../lib";

use Common qw (contains println);

package Day7;

my %CARD_TO_CARDRANK = (
    "2" => 2,
    "3" => 3,
    "4" => 4, 
    "5" => 5,
    "6" => 6,
    "7" => 7, 
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14
); # cheap logic.. if were not using a number, use this map to get a number

# tuple of amount of matching cards mapped to a rank
# i.e. 
# ( 2 ) = 2 cards of 1 same rank
# ( 2, 3 ) = 2 cards of 1 same rank and 3 cards of a different rank
# my %HAND_TYPE_TO_RANK = (
#     ( 1 ) => 1, # worst hand rank
#     ( 2 ) => 2,
#     ( 2, 2 ) => 3,
#     ( 3 ) => 4,
#     ( 2, 3 ) => 5,
#     ( 4 ) => 6,
#     ( 5 ) => 7, # best hand rank
# );

my @HAND_TYPES = (
    { # invalid hand rank...
        'Name' => 'Invalid',
        'CardCount' => [ 0 ],
        'HandRank' => 0
    },
    { # worst hand rank
        'Name' => 'High Card',
        'CardCount' => [ 1 ],
        'HandRank' => 1
    },
    {
        'Name' => 'Pair',
        'CardCount' => [ 2 ],
        'HandRank' => 2
    },
    {
        'Name' => 'Two Pair',
        'CardCount' => [ 2, 2 ],
        'HandRank' => 3
    },
    {
        'Name' => 'Three of a Kind',
        'CardCount' => [ 3 ],
        'HandRank' => 4
    },
    {
        'Name' => 'Full House',
        'CardCount' => [ 2, 3 ],
        'HandRank' => 5
    },
    {
        'Name' => 'Four of a Kind',
        'CardCount' => [ 4 ],
        'HandRank' => 6
    },
    {
        'Name' => 'Five of a Kind? Lol',
        'CardCount' => [ 5 ],
        'HandRank' => 7
    }
);

my @hands = ("11234", "AKKQJ");

# hand type -> hand type rank map -> sorting by rank

sub GetCardCount #(cards)
{
    my @cards = @_;
    my @count;

    # Count the amount of each card in a pile

    # my @testKeys = keys (%TEST);
    # foreach my $card (@cards)
    # {
    #     Common::println ($card);
    # }


    my @cardKeys = keys (%CARD_TO_CARDRANK);
    foreach my $key (sort (@cardKeys))
    {
        # Common::println ("Key: $key");
        my $size = grep ( /$key/ig, @cards);
        if ($size > 0)
        {
            # Common::println ($size);
            push (@count, $size);
        }
    }

    return @count;
}

sub GetHandType #(cards)
{
    my @cards = @_;
    # todo: do something with cards and handcount
    my @cardCount = GetCardCount(@cards);
    Common::println ('GetCardCount!!');
    Common::println ('Hand CardCount: [' . join (',', @cardCount) . ']');
    for my $handType (reverse (@HAND_TYPES))
    {
        Common::println ('Checking '.$handType->{'Name'});
        Common::println ('Count: [' . join (' ', @{$handType->{"CardCount"}}) . ']');
        if (Common::contains (@{$handType->{"CardCount"}}, @cardCount))
        {
            return $handType;
        }
    }
    # If nothing matches, return invalid
    return $HAND_TYPES[0];
}

sub GetHandsOrderedByRank # (hand1, hand2, etc...)
{
    my @hands = @_;
    Common::println ("Ordering hands!");
    for my $hand (@hands)
    {
        Common::println ("[".join (' ', @{$hand})."]");
    }

    my @orderedHands = sort (&HandComp, @hands);

    Common::println ("Ordered hands!");
    for my $hand (@orderedHands)
    {
        Common::println ($hand);
    }

    return @orderedHands;
}

sub HandComp ( $ $ )
{
    my $handA = shift();
    my $handB = shift();

    my @handArrA = @{$handA};
    my @handArrB = @{$handB};

    # First check hand types
    my $handAType = GetHandType (@handArrA);
    my $handBType = GetHandType (@handArrB);

    # If equal: check high card starting with the first card in both hands
    if ($handAType->{'HandRank'} == $handBType->{'HandRank'})
    {
        # Common::println ("Hand Arr A Size: " . scalar (@handArrA));
        foreach (0..scalar (@handArrA) - 1)
        {
            if (CardRankComp ($handArrA[$_], $handArrB[$_]))
            {
                return 1;
            }
            elsif (CardRankComp ( $handArrB[$_], $handArrA[$_] ))
            {
                return 0;
            }
        }
        # If a tie, hand A wins I guess. *shrug*
        return 1;
    }

    return $handAType->{'HandRank'} > $handBType->{'HandRank'};
}

sub CardRankComp ($ $)
{
    my $cardA = shift();
    my $cardB = shift();
    # Common::println "Card A then Card A's numeric rank!!";
    # Common::println $cardA;
    # Common::println $CARD_TO_CARDRANK{$cardA};
    # Common::println "----";
    return $CARD_TO_CARDRANK{"$cardA"} > $CARD_TO_CARDRANK{"$cardB"};
}

return 1;
