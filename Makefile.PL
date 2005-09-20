use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Unicode::RecursiveDowngrade',
    VERSION_FROM => 'lib/Unicode/RecursiveDowngrade.pm',
    PREREQ_PM    => {
	'Test::More' => 0.32,
    },
);
