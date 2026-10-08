# App Banners — manual setup guide

**App Banners** (`appbanners`) helps a website nudge its mobile-web visitors toward
a companion native app. It adds the **Apple Smart App Banner** meta tag and the
**Android** native-app-install banner equivalent to your pages, so mobile browsers
display the standard banner offering to open or install your app.

It is a small marketing / meta-tag feature. There is no complex behaviour and no
security surface — the module simply emits the standard app-association meta tags
in the page head. The one thing to get right is the **app IDs**: enter them
correctly, because a wrong ID points your visitors at the wrong app.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, provide the app identifiers the banners point at — your iOS app ID
(App Store) for the Apple Smart App Banner, and the Android package/app details for
the Android banner — in the module's settings, which are administrator-restricted.
Once the IDs are in place the module emits the meta tags automatically, and mobile
browsers that support the banners will show them.

Because a wrong ID sends visitors to the wrong app, double-check the identifiers,
and test the banner in a supporting mobile browser before going to production.
Leave the module disabled if you do not have a companion app to promote.
