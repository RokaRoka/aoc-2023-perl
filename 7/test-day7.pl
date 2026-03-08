use strict;
use warnings FATAL => "all";
use Test;

BEGIN { plan tests => 7, todo => []}

use FindBin;
use lib "$FindBin::Bin/.";
use lib "$FindBin::Bin/../lib";

use Common qw (contains println);
use Day7;

# testing todos:
# - validate characters in string are valid cards
# - validate there is a valid amount of cards in hand

# Test 1
# Ensure the correct amount of cards are counted in GetCardCount.
# Answers are sorted, the first element of the array should count
# the lowest rank cards, while the end of the array has the
# highest rank cards.
#
# ex. First element should have one "2" card.
#     Last element has four "Ace" cards.
my @cards = split ('', "2AAAA");
my @cardCounts = Day7::GetCardCount(@cards);
ok ($cardCounts[0] == 1 && $cardCounts[1] == 4);


# Temp Test 2 + 3 for Contains
my @arrSmall = (1);
my @arrBig = (1, 2);
# Big contains small but small does NOT (!) contain big
#
ok (contains (@arrBig, @arrSmall));

ok (!contains (@arrSmall, @arrBig));

# Test 2
# Ensure we can match a given hand to its HandType
#
# The hand type is determined by comparing the counted cards in a
# hand to the CardCount property of the matching HandType.
#
# ex. The hand of 11155 (Three "1"s, two "5"s, i.e. cardcount [2, 3]
#     should match the "Full House" HandType.
my @testHand = split ('', '33355');
my $handType = Day7::GetHandType(@testHand);
ok ($handType->{'Name'}, "Full House");

# Test 3
# Check the hand rank of our Full House.
ok ($handType->{'HandRank'}, 5);

# Test 4
# Hand Comp!! Winning Rank

my @winningPlayerHand = split('', 'AAAAA');
my @loserPlayerHand = split('','22456');
ok ( Day7::HandComp (\@winningPlayerHand, \@loserPlayerHand), 1 );

# Hand Comp!! Winning high card
my @winningPlayerHand2 = split('', '333AA');
my @loserPlayerHand2 = split('','33322');
ok ( Day7::HandComp (\@loserPlayerHand2, \@winningPlayerHand2), 0);

my @matchingWinnerHand = split ('', 'AAAAA');
my @matchingWinnerHand2 = split ('', 'AAAAA');
ok ( Day7::HandComp (\@matchingWinnerHand, \@matchingWinnerHand2), 1);
# my @test4GameResults = Day7::GetHandsOrderedByRank(\@winningPlayerHand, \@loserPlayerHand);
# ok (@{$test4GameResults[0]}, $winningPlayerHand);
# ok (@{$test4GameResults[1]}, $loserPlayerHand);

# Test 5
# Corresponding ranks between a full game of hands (4 players)
my @orderedHands = Day7::GetHandsOrderedByRank (\@winningPlayerHand2, \@winningPlayerHand, \@loserPlayerHand);
ok (@{$orderedHands[0]}, @winningPlayerHand);
