package {'apache2':
ensure => present,
}
->
service {'apache2':
ensure => running,
}
exec {'apt-get update':
path => '/usr/bin',
before => Package['apache2'],
}
package {'mysql-server':
ensure => present,
require => Service['apache2'],
}
->
service {'mysql':
ensure => running,
}
package {'php5':
ensure => present,
}
file {'/var/www/html/info.php':
ensure => present,
content => '<?php  phpinfo(); ?>',
}
package {'php5-mysql':
ensure => present,
require => Service['mysql'], 
}
package {'libapache2-mod-php5':
ensure => present,
}
package {'php5-mcrypt':
ensure => present,
}
package {'php5-gd':
ensure => present,
}
package {'libssh2-php':
ensure => present,
}
exec {'mysqladmin -u root password 123@India && touch /var/flagmysqlroot':
path => '/usr/bin',
creates => '/var/flagmysqlroot',
}
file {'/tmp/mysqlcommands':
ensure => present,
source => '/var/mysqlcommands',
}
->
exec {'mysql -uroot -p123@India < /tmp/mysqlcommands && touch /var/flagmysqlcommands':
path => '/usr/bin',
creates => '/var/flagmysqlcommands',
}
->
exec {'wget http://wordpress.org/latest.tar.gz':
cwd => '/root/puppetcodes',
path => '/usr/bin',
creates => '/root/puppetcodes/latest.tar.gz',
}
->
exec {'tar xzvf latest.tar.gz':
cwd => '/root/puppetcodes',
path => '/bin',
}
->
exec {'cp -R /root/puppetcodes/wordpress/* /var/www/html/':
path => '/bin',
creates => '/var/www/html/wp-cron.php',
}
->
file {'/var/www/html/wp-config.php':
ensure => present,
source => '/root/wp-config-sample.php',
}
->
exec {'chown -R www-data:www-data *':
cwd => '/var/www/html',
path => '/bin',
}
->
exec {'mkdir /var/www/html/wp-content/uploads && touch /var/flagmkdir':
path => '/bin',
creates => '/var/flagmkdir',
}
->
exec {'chown -R :www-data /var/www/html/wp-content/uploads':
path => '/bin',
}
file {'/var/www/html/index.html':
ensure => absent,
}










