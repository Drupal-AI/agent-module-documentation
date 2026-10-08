# Configuration

Default Content Tools has two jobs — suppressing imports before they happen, and
deleting content that has already been imported. They live in two different
places in the admin UI.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content Authoring → Default Content Tools**.

## Suppress default‑content imports

On the settings page you can choose to **suppress the automatic import of default
content globally**. With this turned on, when you subsequently install a module
or apply a recipe that would normally import default content through the Default
Content API, that import is skipped — the module/recipe installs, but its sample
content does not.

Because this affects imports that happen *during* installation, set it **before**
you install the modules or apply the recipes whose content you want to skip.

## Delete already‑imported default content

For content that was already imported (before you enabled this module, or before
you turned on suppression), use the deletion feature. This is managed from the
relevant module's or recipe's entry on the **extension page**, where Default
Content Tools lets you remove the default content that item previously imported.

> **Be deliberate about deletion.** Removing default content deletes those
> content entities from your site. If you are unsure whether some of that content
> has since been edited or is in use, review it — and keep a backup — before
> deleting.

## Save

After adjusting the suppression setting, click **Save configuration**. The
setting takes effect for imports that run afterwards.
