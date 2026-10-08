# Show Password — manual setup guide

**Show Password** (`show_password`) is a small usability nicety: it adds a
**"Show Password"** checkbox to Drupal's login form so a user can reveal the password
they are typing and confirm they have not fat-fingered it. Tick the box and the
password field switches from dots to plain text; untick it and the dots return.

It exists because mistyped passwords are one of the most common — and most
frustrating — reasons a login fails, especially on mobile keyboards where you cannot
see what you tapped. Letting people glance at what they typed cuts down on failed
attempts and unnecessary password resets.

The important thing to understand is that this is **entirely client-side and entirely
harmless from a security standpoint**. The checkbox only toggles the visibility of the
value *you* are currently typing in *your own* browser. It never pre-fills the field,
it never sends anything extra to the server, and it cannot read stored passwords or
anybody else's password. There are no routes, no permissions, and no server-side
logic — just a checkbox and a tiny bit of JavaScript.

It works the moment you enable it, with nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to set up beyond enabling the module. Once it is on, visit the login
form (`/user/login`) and you will see the new **Show Password** checkbox beside the
password field. It applies to the standard core login submission unchanged — the only
difference is that users can now choose to see what they type.
