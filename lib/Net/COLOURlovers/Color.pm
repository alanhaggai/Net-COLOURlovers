package    # private
  Net::COLOURlovers::Color;

use strict;
use warnings;

use JSON qw( from_json );

sub color {
    my ( $self, $color ) = @_;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/color/$color?format=json");
    return ( from_json $response->content )->[0];
}

sub colors {
    my ( $self, $args, $url ) = @_;

    $args = Net::COLOURlovers::_build_parametres(
        $args,
        [
            qw(
              lover hueRange briRange keywords keywordExact orderCol sortBy
              numResults resultOffset
              )
        ]
    );

    my $response =
      $self->{'ua'}
      ->post( $url || 'http://www.colourlovers.com/api/colors?format=json',
        $args );

    return from_json $response->content;
}

sub colors_new {
    my ( $self, $args ) = @_;
    return from_json $self->colors( $args,
        'http://www.colourlovers.com/api/colors/new?format=json' );
}

sub colors_top {
    my ( $self, $args ) = @_;
    return from_json $self->colors( $args,
        'http://www.colourlovers.com/api/colors/top?format=json' );
}

sub colors_random {
    my ( $self, $args ) = @_;
    return (
        from_json $self->colors(
            {}, 'http://www.colourlovers.com/api/colors/random?format=json'
        )
    )->[0];
}

1;
