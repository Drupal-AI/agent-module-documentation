# Configuration

Easy Social is configured from a single settings form, with a small section for
each social network.

## Open the settings form

1. Log in as a user with the **Administer Easy Social** (`administer easy_social`)
   permission.
2. Go to **Configuration → Web services → Easy Social**, or navigate directly to
   `/admin/config/services/easy-social`.

## Choose and configure your networks

The form is organised per network — **Email, X/Twitter, Facebook, Pinterest, and
LinkedIn**. For each one you can:

- **Enable or disable the widget** so only the networks you care about appear.
- **Adjust that widget's appearance/behaviour** using the network's own options.

Enable just the networks your audience actually uses — every additional widget is
another third-party script on the page.

> **Note on the Twitter/X widget:** the module's Twitter naming predates the
> rebrand to X and the widget changes that came with it. If you rely on the
> Twitter/X button, test it on the front end before assuming it still behaves as
> expected.

## Placing the widgets

Easy Social can surface the buttons in three ways, so pick whichever fits:

- **Attached to nodes (and comments)** — show the share set automatically on
  content of the types you choose, in a chosen view mode.
- **As a block** — place the share set in any region via **Structure → Block
  layout**, so it can appear outside the content area.
- **As a Views field** — add the Easy Social field to a View to show buttons on
  each row of a listing.

## Privacy and third-party loading — read before going live

This is the most important part of configuring Easy Social. The official network
widgets are **third-party scripts that can track visitors the moment the page
loads**, before anyone clicks a button. Under GDPR and similar regimes, an
always-on share set is a consent-gated technology, not a harmless decoration, and
it is a common finding in privacy audits.

Two practical ways to stay on the right side of this:

- **Gate the widgets behind your consent manager**, so the third-party scripts
  only load after the visitor agrees.
- **Prefer plain share links where you can.** Links of the form
  `https://www.facebook.com/sharer/sharer.php?u=…` (and the equivalents for other
  networks) load **no third-party code at all**, work without JavaScript, and cost
  you only the live share-count display. Many sites replace the widget set with a
  link set outright for exactly this reason.

## Save

Click **Save configuration**. Your enabled networks and their settings take
effect immediately — reload a page where you placed the widgets to see the result.
