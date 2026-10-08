# Configuration

Configuring FullStory Integration is quick, but because it turns on **session
recording**, take the privacy steps below seriously before you point it at real
visitors.

## Open the settings form

1. Log in as a user with the module's FullStory administration permission (an
   administrator by default).
2. Go to the FullStory settings form (config route
   `fullstory.admin_settings_form`).

## Enter your organization ID

The key setting is your FullStory **organization (org) ID**. Find it in the snippet
FullStory provides — the value on the line `window['_fs_org'] = 'ABC123';` (here
`ABC123`). Enter that ID on the settings form and save. Once saved, the module adds
the FullStory JavaScript snippet to your pages and recording begins.

The form also lets you control masking and where the snippet loads — configure these
in line with the privacy guidance below.

## Privacy, consent, and data egress — read before enabling

Session recording captures detailed interaction data and streams it to FullStory, a
third-party service. That carries real responsibilities:

- **Mask sensitive fields.** Session replay can inadvertently capture passwords and
  personal data typed into forms. Use FullStory's field-masking and element-exclusion
  features to keep sensitive inputs out of recordings.
- **Disclose the tracking.** Update your privacy policy to state that you use
  FullStory session recording and what it captures.
- **Gate it behind consent.** This is third-party tracking with GDPR/CCPA
  implications. Integrate it with your cookie/consent management so recording only
  runs for visitors who have agreed.
- **Understand the data flow.** Recorded sessions leave your site and are stored by
  FullStory — factor that into your data-processing agreements and retention
  policies.

The module has no access-control role beyond its own administration permission; it
simply injects the snippet. Everything above is about how responsibly you deploy
that snippet.
