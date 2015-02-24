package PDF::API2::Resource::XObject::Form::QRCode;

our $VERSION = '0.01';

use base 'PDF::API2::Resource::XObject::Form::Hybrid';

use PDF::API2::Util;
use PDF::API2::Basic::PDF::Utils;
use Text::QRCode;

no warnings qw[ deprecated recursion uninitialized ];

=head1 NAME

PDF::API2::Resource::XObject::Form::QRCode

=head1 METHODS

=over

=item $res = PDF::API2::Resource::XObject::Form::QRCode->new $pdf, %opts

Returns a qrcode-form object.

=cut

sub new {
    my ($class,$pdf,%opts) = @_;
    my $self;

    $class = ref $class if ref $class;

    $self=$class->SUPER::new($pdf);

    $self->{' w'}=$opts{-width}  || 100;
    $self->{' h'}=$opts{-height} || 100;
    $self->{' code'}=$opts{-code} || '';
    
	$self->drawqr( Text::QRCode->new()->plot( $self->{' code'} ) );

    return($self);
}

=item $res = PDF::API2::Resource::XObject::Form::QRCode->new_api $api, %opts

Returns a qrcode-form object. This method is different from 'new' that
it needs an PDF::API2-object rather than a Text::PDF::File-object.

=cut

sub new_api {
    my ($class,$api,@opts)=@_;

    my $obj=$class->new($api->{pdf},@opts);
    $obj->{' api'}=$api;

    return($obj);
}

sub outobjdeep {
    my ($self, @opts) = @_;
    $self->SUPER::outobjdeep(@opts);
}

sub drawqr {
    my $self=shift @_;
    my @qr=@{shift @_};
    
    my $s_h=$self->{' h'}/scalar(@qr);
    my $s_w=$self->{' w'}/scalar(@{$qr[0]});
            
    $self->fillcolor('black');
    $self->strokecolor('black');
    
    my ($l,$h) = (0,$self->{' h'});
    for my $line (@qr) {
    	$l=$s_w/2;
    	for my $square (@$line) {	
    		if ($square eq '*') {
    			$self->linewidth($s_w);
				$self->move($l,$h);
				$self->line($l,$h-$s_h);
				$self->stroke;
    		}
    		$l+=$s_w;
    	}
    	$h-=$s_h;
    }
    $self->{BBox}=PDFArray(PDFNum(0),PDFNum(0),PDFNum($self->{' w'}),PDFNum($self->{' h'}));
}

=item $wd = $qrc->width

=cut

sub width {
    my $self = shift @_;
    return($self->{' w'});
}

=item $ht = $qrc->height

=cut

sub height {
    my $self = shift @_;
    return($self->{' h'});
}

1;

__END__

=back

=head1 AUTHOR

Grzegorz Papkala

=cut
