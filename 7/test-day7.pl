use strict;
use warnings FATAL => "all";
use Test;

BEGIN { plan tests => 6, todo => [5, 6]}

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
my $handType = Day7::GetHandType("33355");
ok ($handType->{'Name'}, "Full House");

# Test 3
# Check the hand rank of our Full House.
ok ($handType->{'Rank'}, 5);

# Test 4
# Compare HandRanks between two hands
ok (1);

# Day7::GetHandRank();
#ok (sort (1, 2) eq sort (2, 1));

