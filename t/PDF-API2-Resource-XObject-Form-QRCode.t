# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl PDF-API2-Resource-XObject-Form-QRCode.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 4;
use PDF::API2;

BEGIN { use_ok('PDF::API2::Resource::XObject::Form::QRCode') };

#########################

my $pdf = PDF::API2->new();
$pdf->{forcecompress} = 0;

my $page = $pdf->page();

my $barcode = PDF::API2::Resource::XObject::Form::QRCode->new_api($pdf,
    -code   => 'Some Test Message',
	-width  => 100,
	-height => 100,
);

$barcode->{'-docompress'} = 0;
delete $barcode->{'Filter'};

my $gfx = $page->gfx();
$gfx->formimage($barcode, 100, 100, 1);

my $string = $pdf->stringify();

like($string, qr{/BBox \[ 0 0 100 100 \]},
     q{Barcode is the expected size});

like($string, qr{0 0 0 rg},
     q{Barcode is black});

like($string, qr{q 1 0 0 1 100 100 cm},
     q{Barcode is in the expected location});

