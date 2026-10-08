<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a virtual base prefix

## 1. Module settings
Path: `/admin/config/system/virtual-base` (`administer site configuration`).
- Set the **path prefix** (e.g. `my_prefix`) and enable the feature.
- A node-form validator prevents saving a path alias identical to the prefix.

## 2. Required `.htaccess` rewrite (Apache)
From version 1.0.0-alpha4 onward the module needs server rewrite rules that set a
`VIRTUAL_BASE` environment variable for requests under the prefix. Add to Drupal's
`.htaccess` (replace `my_prefix`):

```apache
# Virtual Base configuration
RewriteRule .* - [E=VIRTUAL_BASE:]

RewriteCond %{REQUEST_URI} ^/my_prefix
RewriteRule .* - [E=VIRTUAL_BASE:/my_prefix]

RewriteCond %{REQUEST_URI} ^/my_prefix
RewriteRule ^my_prefix/(.*)$ /$1 [L]

# cope with apache env variable rewritings when having url redirects
RewriteCond %{ENV:REDIRECT_VIRTUAL_BASE} (.+)
RewriteRule .* - [E=VIRTUAL_BASE:%1]
```

### Restrict to one host
Prepend `RewriteCond %{HTTP_HOST} ^specific\.domain_name\.com` before the
prefix conditions to only activate the base for that domain.

## How it works
- Inbound: `VirtualBasePathProcessor` removes the active prefix so routing matches
  normally.
- Outbound: generated URLs get the prefix re-added when the base is active.
- The `virtual_base` cache context varies cached output by active base so links
  stay correct for both root and prefixed visitors.
