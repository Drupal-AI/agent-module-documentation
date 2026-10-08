# Configuration

Push Framework's own configuration is deliberately thin — it orchestrates, while
the channel modules and the queue do the work. This page covers the settings form,
the parts you must set up outside the form (the queue runner and channel
credentials), and the policy decisions the framework leaves to you.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Push Framework**, or navigate directly to
   `/admin/config/system/push_framework`.

The form is where you set the framework's global behavior and see the channels
that are available. The specific options depend on which channel modules you have
installed, because each channel registers its own plugin. In general you will find
the list of installed **channels** and options that govern orchestration — for
example limiting how a given notification is delivered so users are not "spammed"
with the same message across several channels at once.

## Configure your channels

Each delivery channel is a separate module (Email, Slack, Twilio, OneSignal,
Mattermost, Alerta, …). Install and enable the channel(s) you need, then configure
each one on its own settings page. The channel plugin is what actually talks to the
provider; Push Framework just hands it the message.

## Set up the queue runner (do not skip this)

Push Framework queues outgoing messages through **Advanced Queue**, and **queued
jobs sit untouched until something processes them.** Decide how that happens:

- **Cron** — simplest, but notifications only go out as often as cron runs, so
  "push" becomes "eventually." Fine for low-urgency messages.
- **A dedicated worker** — run the Advanced Queue processor continuously (for
  example via Drush on a schedule or a long-running worker) for near-real-time
  delivery. Choose this if timeliness matters.

Confirm your chosen runner is actually processing the queue after you go live.

## Store channel credentials securely

Push and SMS channels need **provider API keys**. Never hard-code them or commit
them to exported configuration. Store each secret in an environment variable and
reference it through a **Key** entity:

1. Save the value into DDEV's dotenv file (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --some-provider-key=<value>
   ddev restart
   ```
2. Confirm the variable is present in the container **without printing it**:

   ```bash
   ddev exec 'test -n "$SOME_PROVIDER_KEY"'   # exit status 0 means it is set
   ```
3. Create a **Key** entity backed by that environment variable (install the
   [Key](https://www.drupal.org/project/key) module first if needed) and point the
   channel's configuration at the Key rather than pasting the secret into a form.

## Model consent and preference

The framework can respect user preferences for which notifications arrive on which
channels, but **who has agreed to receive what, and how they stop, is a policy
decision it will not make for you.** Before sending to real people, decide how
consent is captured, how per-channel preferences are exposed to users, and how
opt-out is honored — and configure the framework (and DANSE, if used) accordingly.

## Save

Click **Save configuration** on the settings form to apply. Then send a test
notification through a configured channel and confirm it is queued and delivered by
your queue runner.
