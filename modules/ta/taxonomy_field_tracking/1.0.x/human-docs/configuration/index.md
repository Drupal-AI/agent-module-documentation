# Configuration

Taxonomy Field Tracking is configured on one settings form. You enable tracking,
tell it which content to watch and which taxonomy field to count, and point it at
the View that should receive the resulting term IDs.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → Taxonomy Field Tracking**.

## Enable and configure

1. **Enable the tracking.** Turn tracking on at the top of the form.
2. **Choose the bundle.** Select the content type (bundle) whose node views
   should be tracked. Only one field and View are supported per bundle.
3. **Choose the field.** Select the taxonomy‑reference field on that bundle
   whose term IDs should be counted each time one of its nodes is viewed.
4. **Choose the View.** Select the View that should receive the ranked term IDs.
   This should be a simple View with **no exposed filters** and exactly **one
   contextual filter** — the module passes the ranked term IDs into that first
   argument.
5. **Choose how many term IDs to send.** Set how many of the top‑ranked term IDs
   from the visitor's ranking are passed to the View. For example, set it to
   **1** to send only the single most‑viewed term.
6. **Save configuration.**

## How it behaves afterwards

Once configured, every visit to a node of the tracked bundle increments the
per‑term counters for the chosen field. As a visitor keeps browsing, those
counts form a ranking, and the top term IDs are supplied to the configured
View's contextual argument — so the listing that View renders adapts to the terms
that visitor has engaged with most.

Keep the "simple cases" limitation in mind: one field and one View per bundle,
and a target View with a single contextual filter and no exposed filters. If you
need something more sophisticated, this module is not designed for it.
