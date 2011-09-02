package    # private
  Net::COLOURlovers::Pattern;

use strict;
use warnings;

use JSON qw( from_json );

sub pattern {
    my ( $self, $pattern ) = @_;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/pattern/$pattern?format=json");
    return ( from_json $response->content )->[0];
}

sub patterns {
    my ( $self, $args, $url ) = @_;

    $args = Net::COLOURlovers::_build_parametres(
        $args,
        [
            qw(
              lover hueOption hex keywords keywordExact orderCol sortBy
              numResults resultOffset
              )
        ]
    );

    my $response =
      $self->{'ua'}
      ->post( $url || 'http://www.colourlovers.com/api/patterns?format=json',
        $args );

    return from_json $response->content;
}

sub patterns_new {
    my ( $self, $args ) = @_;
    return $self->patterns( $args,
        'http://www.colourlovers.com/api/patterns/new?format=json' );
}

sub patterns_top {
    my ( $self, $args ) = @_;
    return $self->patterns( $args,
        'http://www.colourlovers.com/api/patterns/top?format=json' );
}

sub patterns_random {
    my ( $self, $args ) = @_;
    return (
        $self->patterns(
            {}, 'http://www.colourlovers.com/api/patterns/random?format=json'
        )
    )->[0];
}

1;
