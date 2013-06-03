package gen_drift;
use Moose;
use Statistics::R;
use File::Path 'make_path';

sub simulate {
    my $self = shift;

    $self->_make_tmp_dir;
    my $R = Statistics::R->new();
    $R->run_from_file("genetic_drift.R");
    my $pops        = $self->pops;
    my $size        = $self->size;
    my $generations = $self->generations;
    my $frequency   = $self->frequency;
    my $out         = $self->out;
    $R->run( qq`DoSim(pops        = $pops,
                      size        = $size,
                      generations = $generations,
                      freq        = $frequency,
                      out         = "$out",
                      writeTable  = TRUE)` );
    $R->stop();
}

sub _make_tmp_dir {
    my $self = shift;

    make_path("public/" . $self->out);
}

has pops => (
    is => 'rw',
    isa => 'Num',
);

has size => (
    is => 'rw',
    isa => 'Num',
);

has generations => (
    is => 'rw',
    isa => 'Num',
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
