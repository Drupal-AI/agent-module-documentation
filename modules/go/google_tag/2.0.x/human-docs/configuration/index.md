# Configuration

All of Google Tag's setup happens on the **Google Tag Global settings** page. Here
you add the **tag containers** that hold your measurement/GTM IDs and control
site-wide behaviour such as whether more than one container is allowed.

## Open the settings page

1. Go to **Configuration → Services → Google Tag**
   (`/admin/config/services/google-tag`).
2. The **Google Tag Global settings** page opens. It is organised into three tabs
   — **Tag Settings**, **Advanced**, and **Additional Tags**.

![The Google Tag Global settings page, Advanced tab](../images/settings.png)

## Site-wide behaviour: Allow multiple Tag Containers

The **Advanced** tab holds the module-wide options. Under **Module settings**
there is one key checkbox:

- **Allow multiple Tag Containers** — when this is off, the site uses a single
  default container. When it is on, you can create and manage several containers.
  As the help text notes, *for most users only one tag container is required* —
  each container represents a set of visibility conditions and events and can hold
  one or more measurement IDs, so you only need multiple containers when your
  configuration needs to differ per set of measurement IDs.

After changing anything on this tab, click **Save configuration**.

## Add a tag container

A **tag container** is the unit that actually loads a Google snippet. To create
one, click the **+ Add measurement container** button on the settings page. A
container brings together three things:

### 1. One or more tag / measurement IDs

Enter the IDs you want this container to load. Google Tag accepts the full range
of Google tag IDs:

- `G-…` — a **Google Analytics 4** measurement ID.
- `GTM-…` — a **Google Tag Manager** container ID.
- `AW-…` — a **Google Ads** ID.
- `UA-…`, `DC-…`, `GT-…` — other Google tag types.

A single container can hold several IDs at once — for example a GA4 property and a
Google Ads conversion tag together. IDs beginning with `GTM-` cause the container
to load the Google Tag Manager (`gtm.js`) snippet; all other IDs load the Google
tag (`gtag.js`) snippet. The module validates the format of each ID you enter.

### 2. Conditions — where the container fires

**Conditions** decide on which requests the container's snippet is injected. They
are Drupal's standard visibility Condition plugins, and the ones that matter most
for tracking are:

- **Request path** — restrict the container to specific paths, or exclude paths.
  Use this to load a tag only on certain sections of the site, or to keep it off
  the admin area.
- **Response code** — skip error responses such as 403 and 404 so you are not
  recording analytics hits for pages that were not found.

Set the conditions so the container fires exactly where you want it and nowhere
else.

### 3. Custom dimensions and metrics (optional)

A container can also carry **custom dimensions and metrics** — extra name/value
pairs sent along with your tag. Their values support **tokens**, so you can
populate them from the current page or entity (this needs the **Token** module).
This is optional and can be left empty for a basic setup.

Give the container a **label**, make sure it is **enabled**, and save it.

## Enabling and disabling containers

You do not have to delete a container to stop it firing — each container can be
**enabled or disabled** independently, so you can switch tracking off (for
example on a staging environment) and turn it back on later without losing the
configuration.

## Save

Remember to click **Save configuration** on the global settings page after
changing the module-wide options, and to save each container after editing it.
Once a container is enabled with a valid ID and matching conditions, Google Tag
injects the snippet into every matching page response automatically — no template
edits required.
