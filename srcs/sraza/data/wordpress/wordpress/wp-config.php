<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'WordPress' );

/** Database username */
define( 'DB_USER', 'sraza42' );

/** Database password */
define( 'DB_PASSWORD', 'sraza42' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '2.h:Ea)iiYQ^-GX1C#YXE6LE>RGq@pB|%Y@#4Nx7HZAvT/(=|d^]Z+9?V=Gh;K2s' );
define( 'SECURE_AUTH_KEY',   '>j:c5^H&MF&opKfgiNA-&5s5e/XtOi3G`,>qO)7Nss|nWRO:(7]SOMpky`ZOpS*e' );
define( 'LOGGED_IN_KEY',     ' cmfZO_3BmIb.DhXM<<P 3wl.-1%hY0WC9f%H7tO=&:boVT>zv|t_y7X(*r_mf3W' );
define( 'NONCE_KEY',         'RpfmB?(r%h2ESq>lVyF5?.pe0|,7b!dCbsa*UyfjP}Dxx(,Md vDKt/K$(U*f7~s' );
define( 'AUTH_SALT',         'F#U5VG})VQiYwJ*Uj.on>/Ud5=UQs`Zqf|6:+-fCl.i>hyrJ~K;`gOutM6)`_=p)' );
define( 'SECURE_AUTH_SALT',  'x2*Mw(=.>^XTE$B}:.a{Ez/m1:j>u3mV&u.I1.vz`(0yfBi/GIi@BFfeOGWhIUP>' );
define( 'LOGGED_IN_SALT',    'e4`Ou,T_aQ}Mp>We+5h)OM}tO&BI8z*tuqrv-$%4us0SuCWvu8bZcCJ*a;qcl#`T' );
define( 'NONCE_SALT',        'Ax5|_Sx0R5,?+yg}e[^dh{|rQC4/Hjfj{({-[IuD4:{lWf{i}_iD$*jX%Ip)1VXD' );
define( 'WP_CACHE_KEY_SALT', ';.^HoYyIEi7@Wha:Z.uazK7?x6 2a $CzRN|tIk=YjSQta@*Q7quy&jFV~aWNYAX' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
