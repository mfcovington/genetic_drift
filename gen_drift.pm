package gen_drift;
use Moose;
use Statistics::R;

sub simulate {
    my $self = shift;

    my $R = Statistics::R->new();
    $R->run_from_file("genetic_drift.R");
    my $pops        = $self->pops;
    my $size        = $self->size;
    my $generations = $self->generations;
    my $frequency   = $self->frequency;
    my $out         = $self->out;
    $R->run( qq`DoSim(pops = $pops, size = $size, generations = $generations, freq = $frequency, out = "$out", writeTable = TRUE)` );
}

has pops => (
    is => 'rw',
    isa => 'Int',
);

has size => (
    is => 'rw',
    isa => 'Int',
);

has generations => (
    is => 'rw',
    isa => 'Int',
);

has frequency => (
    is => 'rw',
    isa => 'Num',
);

has out => (
    is => 'rw',
    isa => 'Str',
);

no Moose;
__PACKAGE__->meta->make_immutable;
