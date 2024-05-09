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
define( 'AUTH_KEY',          'xFFy|Tj?]blL9V[7TFn1BpX/rwD>+<_KxE=zXO$3?j.He]d5^Xph`eKOCrWlx9c(' );
define( 'SECURE_AUTH_KEY',   'm&tYM!C/ {#}D}fdr.E2O4@Xl=vj(d&Gb]m4W2+5v`XT`HC@SjQ[3tt=@;EY<3I2' );
define( 'LOGGED_IN_KEY',     '^j>FLxlgc8><:N=W#k6Q<0W-%|^!0+>nu1? <KZup/d(pCAM&H;&8nd2:2o$j| n' );
define( 'NONCE_KEY',         'J3,A%ehT`#XE06&jGTo#]GoDrS`px{SWBy&VKFZ*XMxb}0&pb8mJ1+7-+.+Fty`h' );
define( 'AUTH_SALT',         ':s:{=W#Lz&65>bd0:]Ly3e!x0EU/??.J7Y#A6mj=$(u[1XNY=-lV/i2DOoCAuu4R' );
define( 'SECURE_AUTH_SALT',  '5Dv8GIhT1U=MZQ%@7uo$!17)1d.3)lVtM5W=m{[*P@GF+IL5yi&*A#A. kl@SAXE' );
define( 'LOGGED_IN_SALT',    'wcOx^cG^Ej:o;?:$0pb)M]PE]>*|1Id2&m!~g|bE_Zt<P&c`XUvxzGx-VM`~T5ar' );
define( 'NONCE_SALT',        '+xI4P?hK#eGs%OgHlJ!<PzZKP<@Y L)iZ(x9FGaL_k2.3?Ak]4^?|]xGz~>vE6Io' );
define( 'WP_CACHE_KEY_SALT', ':Y[l}>^t LV.5J5D$dddz34n9J>*{Njx1:21FH*VM&ci`w K*_YO$:!dShLC}I$l' );


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
