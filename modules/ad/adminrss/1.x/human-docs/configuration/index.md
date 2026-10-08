# Configuration

Admin RSS keeps its moderation settings in one place.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Admin RSS**, or navigate directly to
   `/admin/config/services/adminrss`.

## What you configure here

This is where you manage the moderation / approval workflow for queued feed items
— reviewing items that have arrived through feed queues and approving or rejecting
them before they are published or processed.

> **Documentation is limited for this module.** Its published docs do not describe
> each individual field, and the release is a development snapshot, so the exact
> set of options may vary by version. Open the form on your own site to see the
> current fields, set the options to suit how you want feed items reviewed, and
> save. Because this gates content ingestion, test the approve and reject paths on
> a non-production environment before relying on it.
