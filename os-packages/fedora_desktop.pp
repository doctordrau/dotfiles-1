$yumgroups = [ "standard", "base-x", "c-development" ] 
$chrome = [ 'https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm' ]

$userenv = [ "git", "zsh", "vim-minimal", "screen", "python-virtualenvwrapper", "vpnc" ]

$desktop = ['slim', 'rxvt-unicode-256color', 'gtk-chtheme', 'gtk2-engines', 'alsa-utils', 'compton', 'xscreensaver', 'dmenu', 'network-manager-applet', $chrome]

$fonts = ['terminus-fonts', 'google-droid-sans-fonts', 'google-droid-serif-fonts', 'google-droid-sans-mono-fonts', 'levien-inconsolata-fonts']

$apps = ['firefox', 'mpd', 'mpc', 'ncmpcpp']

define yumgroup($ensure = "present", $optional = false) {
   case $ensure {
      present,installed: {
         $pkg_types_arg = $optional ? {
            true => "--setopt=group_package_types=optional,default,mandatory",
            default => ""
         }
         exec { "Installing $name yum group":
            command => "/bin/yum -y groupinstall $pkg_types_arg $name",
            unless => "/bin/yum -y groupinstall $pkg_types_arg $name --downloadonly",
            timeout => 600,
         }
      }
   }
}


##
# creates a repo release file by downloading the $source
#
# $name: name of repository (creates ${name}.repo file)
# $source: URL to *-release rpm
define packages::repo_release ($source) {
        exec { $name:
                command =>"/bin/rpm -Uvh ${source}",
                creates => "/etc/yum.repos.d/${name}.repo",
        }
}

class box {
	yumgroup { $yumgroups: ensure => installed }

	package { [
		$userenv,
		$desktop,
		$fonts,
		$apps,
	]: ensure => "installed" }


    file { '/etc/systemd/system/default.target':
        ensure => link,
        target => '/usr/lib/systemd/system/graphical.target'
    }

    packages::repo_release { "rpmfusion-free": source => "http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm", }
    packages::repo_release { "rpmfusion-nonfree": source => "http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm", }
    package { [
            "rpmfusion-free-release",
            "rpmfusion-nonfree-release",
            ]:
            ensure => latest,
            require => [
                    Packages::Repo_release["rpmfusion-free"],
                    Packages::Repo_release["rpmfusion-nonfree"],
            ],
    }

    packages::repo_release { "infinality-repo": source => "http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm", }
    package { [ "freetype-infinality", "infinality-settings" ]:
        ensure => latest,
        require => [ Packages::Repo_release["infinality-repo"] ];
    }
}

include box
