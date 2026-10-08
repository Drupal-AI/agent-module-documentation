# Swoosh — manual setup guide

**Swoosh** (`swoosh`) is the Drupal beacon for the Swoosh real-user
performance-monitoring service. Once enabled, it collects **Core Web Vitals** —
metrics such as Largest Contentful Paint (LCP), Cumulative Layout Shift (CLS),
and Interaction to Next Paint (INP) — from real visitors' browsers as they use
your site, and sends those measurements to the Swoosh backend for storage and
reporting.

The point of real-user monitoring is that it measures how the site actually
performs for the people using it, on their real devices and connections, rather
than in a synthetic lab test. Swoosh gives you that signal without you writing
any front-end measurement code: the module drops in the beacon and the numbers
flow to the Swoosh service. It works on Drupal 10 and 11 and has no other module
dependencies.

Two things are worth knowing before you deploy it. First, this is an **external
integration**: performance measurements — and potentially page URL or session
context — leave your site and go to the third-party Swoosh backend. Treat that
as data egress: disclose it in your privacy policy and consider whether visitor
consent is required for the tracking in your jurisdiction. Any credentials or
site key the beacon uses to talk to the Swoosh backend should be handled as a
secret, not committed to code. Second, this release is an early **alpha**
(1.0.0-alpha4), so expect it to still be settling.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Swoosh works as a background beacon — there is nothing for a
visitor to click. It measures Core Web Vitals in the browser and reports them to
the Swoosh service, where you view the results and reporting. You will need a
Swoosh account/backend to receive and display the data; connect the site to your
Swoosh backend (and provide any site key it requires) following Swoosh's own
onboarding, keeping any credential out of version control.
