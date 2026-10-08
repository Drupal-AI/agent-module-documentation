# Configuration

Setting up Email Manager has three parts: make sure the module's mail plugin
handles the emails you want to customise, define (or confirm) the email keys, and
author a template for each key. All of this happens under **Administer email
templates**, so grant that permission first (see
[Installation](../installation/index.md)).

## Step 1 — Use Email Manager as the mail plugin

Email Manager only rewrites messages that pass through its **`EmailManagerMail`**
mail plugin. In Drupal's mail system settings, set `email_manager` as the mail
plugin for the module/keys you want it to handle (or globally, if you want it to
handle all outbound mail). Until this is done, your templates exist but nothing
is intercepted.

## Step 2 — Review the email keys

Go to **Configuration → System → Email Manager → Keys**
(`/admin/config/system/email-manager/keys`). Each key is a `module:key` pair
identifying one kind of email (for example a registration email). Keys are
**auto‑discovered**, so most of the messages your site sends should already be
listed.

If a key you need is missing, a developer can declare it — either in a
`your_module.email_manager.yml` file in the module root:

```yaml
email_keys:
  custom_email: 'Custom Email'
  another_email: 'Another Email'
```

or via the alter hook:

```php
function hook_email_manager_keys_alter(array &$email_keys) {
  $email_keys['mymodule:welcome'] = 'Welcome (mymodule)';
}
```

## Step 3 — Author a template

1. Go to **Configuration → System → Email Manager**
   (`/admin/config/system/email-manager`) and add a template.
2. **Bind it to a key** — choose the `module:key` this template should replace.
3. Enter the **subject** line.
4. Write the **body** in the CKEditor rich‑text editor. Insert **tokens** where
   you want dynamic values — core tokens plus the module's own
   `email_manager:module` and `email_manager:key` tokens. The body is sent as
   HTML.
5. Save the template.

At send time, when Drupal generates a message for that module/key, Email Manager
looks up your template, replaces the tokens, and formats the body as HTML.

## Verify

Trigger the email you customised (for example create a test user to fire the
registration email) and confirm the delivered message uses your template's
subject and HTML body. Templates are stored as exportable configuration entities,
so you can move them between environments with configuration sync.
