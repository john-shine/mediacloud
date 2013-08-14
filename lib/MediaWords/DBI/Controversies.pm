package MediaWords::DBI::Controversies;

# various functions dealing with the controversies table

use strict;

# get a list controversies that match the controversy option, which can either be an id
# or a pattern that matches controversy names. Die if no controversies are found.
sub require_controversies_by_opt
{
    my ( $db, $controversy_opt ) = @_;

    my $controversies;
    if ( $controversy_opt =~ /^\d+$/ )
    {
        $controversies = $db->query( "select * from controversies where controversies_id = ?", $controversy_opt )->hashes;
        die( "No controversies found by id '$controversy_opt'" ) unless ( @{ $controversies } );
    }
    else
    {
        $controversies = $db->query( "select * from controversies where name ~* ?", '^' . $controversy_opt . '$' )->hashes;
        die( "No controversies found by pattern '$controversy_opt'" ) unless ( @{ $controversies } );
    }

    return $controversies;
}

1;
