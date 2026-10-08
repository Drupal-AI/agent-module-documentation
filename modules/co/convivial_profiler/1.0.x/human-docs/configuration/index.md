# Configuration

Convivial Profiler does nothing until you configure it. This is also where you
take on responsibility for the privacy side of profiling, so read the caution at
the end before you switch it on for real visitors.

## Open the settings form

1. Log in as a user with permission to administer the profiler.
2. Go to **Configuration → Convivial → Profiler**, or navigate directly to
   `/admin/config/convivial/profiler`.

The module's own guidance is simply: "set all the configuration options" on this
page. It is where you define how the profiler collects behavior, builds the
visitor profile, and handles consent.

## What you configure here

- **Profiling behavior** — how the profiler observes visitor interests and
  actions and turns them into a stored profile.
- **Where the profile lives** — the profile may be built in the browser and/or on
  the server and stored accordingly; this affects your privacy obligations.
- **Consent handling** — how the profiler respects a visitor's consent choice so
  that profiling only happens when it is permitted.

Save the form when you are done. Because the exact fields evolve with the module's
alpha releases, work through each option on the page rather than assuming a fixed
list.

## Privacy: configure this deliberately

Profiling collects **behavioral and personal data**, which is regulated under GDPR
and ePrivacy. Before you profile real visitors:

- **Disclose** the profiling in your site's privacy policy.
- **Obtain consent** where the law requires it, and make sure the profiler only
  runs after consent is given.
- **Let visitors opt out**, and honor that choice.
- **Avoid sensitive categories** of data entirely.

The profiler decides what a visitor *sees* (personalization), never what they are
*permitted* to access — do not treat it as an access control.
