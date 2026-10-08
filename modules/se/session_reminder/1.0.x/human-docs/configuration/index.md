# Configuration

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → People → Session Reminder**, or navigate directly to
   `/admin/config/session-reminder`.

The form is split into a **Functional** section and a **Style** section. If your
`gc_maxlifetime` is set to `0`, a warning appears here because the reminder can't
function in that state.

## Functional settings

- **Warning Threshold** — how many seconds before the session expires the modal
  should appear. Set it far enough ahead that a user has time to react, but not so
  early that it nags. This is measured against the session's expiry, which the module
  derives from your `cookie_lifetime`.
- **User Roles** — which roles see the reminder. Only authenticated users are
  eligible; tick the roles that should get the modal and leave the rest unchecked.

## Style settings

The **Style** tab lets you match the modal to your site's look, with a **live
preview** that updates instantly as you change each option so you can see the result
before saving. The available options are:

- **Modal Background Color** — the overall background of the modal window.
- **Modal Title Color** — the color of the modal's title text.
- **Modal Text Color** — the color of the body text inside the modal.
- **Submit Button Background Color** — the background color of the extend/submit
  button.
- **Submit Button Text Color** — the color of the text on that button.

Experiment freely with the live preview until the modal matches your theme.

## About the session lifetime

The module calculates when to warn from Drupal's `cookie_lifetime`
(defined in `services.yml`; the default is 200,000 seconds, roughly 56 hours). The
extend button updates the session cookie's expiration based on that same value.
Remember that `gc_maxlifetime` set to `0` disables session-data expiry entirely and
stops the modal from working — keep it at a real value.

## Save

Click **Save** to apply your settings. Authenticated users in the selected roles
will then see the reminder as their session nears the threshold you chose.
