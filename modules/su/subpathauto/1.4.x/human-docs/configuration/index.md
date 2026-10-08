# Configuration

Sub-pathauto works out of the box — this form only tunes two things: how deeply it
searches for a parent alias, and whether it cooperates with the Redirect module.

## Open the settings form

1. Log in as a user with the **Administer URL aliases** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Sub-path settings**, or navigate
   directly to `/admin/config/search/subpathauto`.

## Maximum depth

This dropdown controls how many trailing segments the module will strip off a URL
while hunting for a parent alias. If you set it to **1**, the module only tries the
immediate parent — enough for the everyday cases like `/about-us/edit` and
`/about-us/delete`. A higher value reaches deeper routes such as
`/about-us/webform/results/download`, at the cost of one extra alias lookup per
level on every request that doesn't already match an alias.

A word of caution about the labels on this dropdown:

- The option **Disabled** in the list is stored as `0`, but internally the module
  treats `0` as **no limit** (search all the way down). This `0` = unlimited value
  is the shipped default, and it is fine on small and medium sites.
- The genuine "off" switch is to remove the setting entirely (delete the
  `subpathauto.settings` config object). That is an edge case you'd only reach
  through configuration management, not the form.

In short: pick **1** or **2** if you have a very large site and want to limit the
lookups; leave it at the default if you're not sure.

## Support for redirects

This checkbox lets Sub-pathauto resolve a sub-path against an *old* alias by first
consulting the [Redirect](https://www.drupal.org/project/redirect) module. When
it's on and you've renamed a page, a bookmarked child path like
`/old-name/edit` still resolves because the module follows the redirect to the
current alias before doing its sub-path lookup.

- The checkbox is **only available when the Redirect module is installed** — if
  Redirect isn't present, the option is greyed out and forced off.
- On brand-new installs this is turned **on** by default; sites upgrading from an
  older version keep it **off** so their behavior doesn't change unexpectedly.

## Save

Click **Save configuration**. Because a depth or redirect change can alter the URLs
Drupal generates, saving this form clears every cached page — expect a brief cold
cache while pages rebuild. Your new settings take effect immediately afterward.
