# Calendar Links Tokens — manual setup guide

**Calendar Links Tokens** (`calendar_links_token`) generates "add to calendar"
links — for Google Calendar, iCal/Outlook, and other calendar services — using
Drupal **tokens**. Where the related Calendar Link module works through Twig
functions in templates, this module works through the token system: an event's
date, title, and details are turned into calendar links by token replacement, so
you can place the links wherever tokens are supported, such as in content or
templates.

The result is the familiar one-click "add this event to your calendar"
experience for your visitors. The links are derived entirely from the event data
you feed the tokens; the module has no access-control role and no settings of its
own.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives

Calendar Links Tokens has no admin settings page. Once enabled, it provides
tokens that produce the calendar links; you use those tokens wherever you want
the links to appear.

## How to use it

Enable the module, then place its calendar-link tokens in the content or
template where the "add to calendar" links should show up — pointing them at your
event's date, title, and detail values. Token replacement turns them into the
finished links for Google, iCal, Outlook, and the other supported services. The
Token module's token browser (if installed) is the easiest way to discover the
exact token names available.
