package    # private
  Net::COLOURlovers::Palette;

use strict;
use warnings;

use JSON qw( from_json );

sub palette {
    my ( $self, $palette ) = @_;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/palette/$palette?format=json");
    return ( from_json $response->content )->[0];
}

sub palettes {
    my ( $self, $args, $url ) = @_;

    $args = Net::COLOURlovers::_build_parametres(
        $args,
        [
            qw(
              lover hueOption hex keywords keywordExact orderCol sortBy
              numResults resultOffset showPaletteWidths
              )
        ]
    );

    my $response =
      $self->{'ua'}
      ->post( $url || 'http://www.colourlovers.com/api/palettes?format=json',
        $args );

    return from_json $response->content;
}

sub palettes_new {
    my ( $self, $args ) = @_;
    return $self->palettes( $args,
        'http://www.colourlovers.com/api/palettes/new?format=json' );
}

sub palettes_top {
    my ( $self, $args ) = @_;
    return $self->palettes( $args,
        'http://www.colourlovers.com/api/palettes/top?format=json' );
}

sub palette_random {
    my ( $self, $args ) = @_;
    return (
        $self->palettes(
            {}, 'http://www.colourlovers.com/api/palettes/random?format=json'
        )
    )->[0];
}

1;
