# Piano Analytics for TacJS — manual setup guide

**Piano Analytics for TacJS** (`tacjs_pianoanalytics`) connects **Piano Analytics**
to the **TacJS** cookie-consent manager, so that Piano Analytics tracking loads
only *after* a visitor has given consent through the TacJS (tarteaucitron.js)
consent banner. In practice, it registers Piano Analytics as a consent-managed
service inside TacJS — a common pattern for keeping analytics GDPR-compliant, since
the tracker only fires once the visitor has opted in.

It is a small integration glue module: it depends on both the **Piano Analytics**
module (`pianoanalytics`), which provides the actual tracking, and the **TacJS**
module (`tacjs`), which provides the consent UI and gating. This module's job is
simply to make the two work together. It supports Drupal 10 and 11.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Piano Analytics and TacJS.

## How to use it

There is no separate settings screen for this bridge module. Configure **Piano
Analytics** with your tracking details and set up your **TacJS** consent banner as
usual; with this module enabled, Piano Analytics appears as a consent-managed
service so its tracking is held back until the visitor consents. The consent
gating itself is handled by TacJS.
