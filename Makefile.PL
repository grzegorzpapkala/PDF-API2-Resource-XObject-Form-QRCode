use 5.012004;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'PDF::API2::Resource::XObject::Form::QRCode',
    VERSION_FROM      => 'lib/PDF/API2/Resource/XObject/Form/QRCode.pm', # finds $VERSION
    PREREQ_PM         => {'Text::QRCode' => '0.01', 'PDF::API2' => '2.0'}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/PDF/API2/Resource/XObject/Form/QRCode.pm', # retrieve abstract from module
       AUTHOR         => 'Grzegorz Papkala <papkala@macosforge.org>') : ()),
);
