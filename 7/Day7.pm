use strict;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Common;
use Array::Utils qw(:all);

package Day7;

my %CARD_TO_RANK = (
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
    {
        'Name' => 'High Card',
        'CardCount' => [ 1 ],
        'Rank' => 1
    }, # worst hand rank
    {
        'Name' => 'Full House',
        'CardCount' => [ 2, 3 ],
        'Rank' => 5
    } # worst hand rank
    # ( 2 ) => 2,
    # ( 2, 2 ) => 3,
    # ( 3 ) => 4,
    # ( 2, 3 ) => 5,
    # ( 4 ) => 6,
    # ( 5 ) => 7, # best hand rank
);

my @hands = ("11234", "AKKQJ");

# hand type -> hand type rank map -> sorting by rank

sub GetCardCount #(cards)
{
    my @cards = @_;
    my @count;

    # Count the amount of each card in a pile

    # my @testKeys = keys (%TEST);
    foreach my $card (@cards)
    {
        Common::println ($card);
    }


    my @cardKeys = sort (keys (%CARD_TO_RANK));
    foreach my $key (@cardKeys)
    {
        Common::println ("Key: $key");
        # Common::println ("Matching: $key");
        # Common::println ($hand =~ m/$key/);
        my $size = grep ( /$key/ig, @cards);
        Common::println ($size);
        if ($size > 0)
        {
            push (@count, $size);
        }
    }

    return @count;
}

sub GetHandType #(cards)
{
    my @cards = @_;
    # todo: do something with cards and handcount
    return $HAND_TYPES[$#HAND_TYPES];
}

sub GetHandRank #(cardCounts)
{
    # working from the best hand, Look at
    # each card count and try to match the best
    # my @handTypes = sort ( keys (%HAND_TYPE_TO_RANK) );
    # for ( my $i = 0; $i < @handTypes; $i++ )
    # {
    #     print "( ";
    #     foreach my $cardCount ((@{$handTypes[$i]}))
    #     {
    #         print $cardCount;
    #     }
    #     print ")\n";
    # }


    foreach my $handType (@HAND_TYPES)
    {
        Common::println ($handType);
        my $rank = $handType->{'Rank'};
        Common::println ("Rank: $rank");

        my @cardCounts = @{$handType->{'CardCount'}};
        print "Card counts:";
        foreach my $count (@cardCounts)
        {
            print " $count";
        }
        Common::println ("");
    }
}


return 1;
