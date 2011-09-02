package    # private
  Net::COLOURlovers::Stat;

use strict;
use warnings;

use JSON qw( from_json );

sub stats_colors {
    my $self = shift;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/stats/colors?format=json");

    return ( from_json $response->content )->{'total'};
}

sub stats_lovers {
    my $self = shift;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/stats/lovers?format=json");

    return ( from_json $response->content )->{'total'};
}

sub stats_palettes {
    my $self = shift;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/stats/palettes?format=json");

    return ( from_json $response->content )->{'total'};
}

sub stats_patterns {
    my $self = shift;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/stats/patterns?format=json");

    return ( from_json $response->content )->{'total'};
}

1;
