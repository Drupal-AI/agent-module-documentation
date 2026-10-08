# Configuration

Cash DOM is primarily a developer tool — the usual way to use it is to declare
`cash/cash` as a dependency of your own library (see the main
[guide](../index.md)). Everything on this page is **optional** and only exists as
a convenience.

## Open the settings form

1. Log in as a user with the **Administer cash** permission (`administer cash`).
2. Go to **Configuration → Media → Cash**, or navigate directly to
   `/admin/config/media/cash`.

## What the form does

The form provides a convenient way to attach the Cash library **site-wide**,
without editing any `*.libraries.yml` file or writing a render array. Turn it on
here if you want Cash loaded on every page; leave it off (the default) if you'd
rather attach the library only where it's actually needed, which is the leaner,
recommended approach.

## Save

Save the form, then reload a front-end page and check the page source — if
site-wide loading is enabled, `cash.min.js` should now be present. Remember that
the library file must already be in place under `libraries/` (see
[Installation](../installation/index.md)); the form only controls *whether* it is
attached, not where the file lives.
