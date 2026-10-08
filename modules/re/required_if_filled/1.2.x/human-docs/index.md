# Required If Field Has Value — manual setup guide

**Required If Field Has Value** (`required_if_filled`) makes one field required
only when *another* field has been filled in. Instead of a field being always
required or always optional, you define rules such as "make the phone number
required only when an email address is entered" or "require warranty details only
when a warranty option is selected." The requirement adapts to what the person is
actually entering on the form.

It works with all fieldable entity types — content (nodes), users, taxonomy terms,
and custom entities — and understands complex field types: it strips HTML from
CKEditor fields to detect real content, correctly detects uploaded images and
files, and handles entity reference and link fields. You configure everything from
a friendly rules table with dropdown selects, so you never have to remember field
machine names.

One thing to keep in mind: a field you want to make conditionally required must
*not* already be marked as required in its own field settings. Fields that are
always required cannot be used as the "required field" in a rule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

All setup happens on the rules screen described in "How to use it" below.

## Where it lives in the admin menu

The rules screen sits at **Configuration → Content → Required If Field Has Value**
(`/admin/config/content/required-if-filled`). You need the **Administer site
configuration** permission (an administrator by default) to reach it.

## How to use it

1. Go to **Configuration → Content → Required If Field Has Value**
   (`/admin/config/content/required-if-filled`).
2. Click **Add another rule**.
3. For the new rule, choose:
   - **Entity type** — Content, User, Taxonomy Term, and so on.
   - **Bundle** — the specific type (Article, Page, User, and so on).
   - **Source field** — the field that, when filled, triggers the requirement.
   - **Required field** — the field that becomes required when the source field
     has a value. (This field must not already be required in its own settings.)
4. Add more rules as needed, then click **Save configuration**.

From then on, whenever someone fills the source field on a matching form, the
module validates that the required field is also filled and shows a clear error
message naming the field if it is not.

> **Tip:** If a new rule does not seem to take effect immediately, clear Drupal's
> cache. If you are upgrading from the 1.0.x line, existing rules are migrated
> automatically — no manual work is needed.
