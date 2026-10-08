# Configuration

Setting up Override Media Options has two parts: granting the per‑field
**permissions** that unlock the authoring and publishing fields, and (optionally)
visiting the module's **settings form** to control which options are available.

## Step 1 — grant the per‑field permissions

1. Log in as a user with the **Administer permissions** permission (an
   administrator by default).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the Override Media Options permissions. Each one corresponds to a single
   field in the **Authoring information** or **Publishing options** field set on
   the media form — for example the ability to change the **published status**,
   the **authored by** (author) value, or the **authored on** (created date).
4. Tick the box for each role that should be allowed to override that field, then
   click **Save permissions**.

Grant only what each role genuinely needs. Remember that a user must already have
edit access to a media item for these fields to appear — the permissions add the
extra fields on top of existing edit access; they do not grant edit access on
their own.

> **Security note:** granting the override‑published‑status permission lets those
> users publish and unpublish media. Treat each permission as a deliberate trust
> decision and confirm the assignments match your editorial workflow before
> relying on them.

## Step 2 — the settings form

1. Go to **Configuration → Content authoring → Override Media Options**
   (`/admin/config/content/override-media-options`).
2. Use the form to fine‑tune which of the authoring/publishing options are
   exposed for overriding. Turn off any option you never want editors to touch,
   even if the corresponding permission is granted.
3. Click **Save configuration**.

## Verify

Open a media item's edit form as a user in one of the roles you granted a
permission to. The authoring/publishing fields you enabled should now be visible
and editable for that user.
