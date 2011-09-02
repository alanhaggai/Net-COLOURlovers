package    # private
  Net::COLOURlovers::Lover;

use strict;
use warnings;

use JSON qw( from_json );

sub lover {
    my ( $self, $lover ) = @_;

    my $response =
      $self->{'ua'}
      ->post("http://www.colourlovers.com/api/lover/$lover?format=json");
    return ( from_json $response->content )->[0];
}

sub lovers {
    my ( $self, $args, $url ) = @_;

    $args =
      Net::COLOURlovers::_build_parametres( $args,
        [qw( orderCol sortBy numResults resultOffset )] );

    my $response =
      $self->{'ua'}
      ->post( $url || 'http://www.colourlovers.com/api/lovers?format=json',
        $args );

    return from_json $response->content;
}

sub lovers_new {
    my ( $self, $args ) = @_;
    return $self->lovers( $args,
        'http://www.colourlovers.com/api/lovers/new?format=json' );
}

sub lovers_top {
    my ( $self, $args ) = @_;
    return $self->lovers( $args,
        'http://www.colourlovers.com/api/lovers/top?format=json' );
}

1;
