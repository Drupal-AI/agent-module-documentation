# Configuration

Advanced 403 Redirect is driven by a small set of admin settings that decide
where an access-denied response sends the visitor.

## Who can configure it

The module provides its own permission for managing the redirect. Grant it on
**People → Permissions** (`/admin/people/permissions`) to the roles that should
be allowed to change the 403 behavior, then log in as one of those users to edit
the settings.

## Set the redirect destination and rules

On the module's settings you choose the **destination** a 403 response should be
sent to — commonly the login page (so anonymous users hitting a protected page
are prompted to sign in) or a custom "you don't have access" page. Redirect rules
let you shape when the redirect applies.

Because the destination is fixed by you as an administrator rather than taken
from the incoming request, it cannot be manipulated by a visitor to redirect
elsewhere.

## What it does not do

This module only changes **where** a denial sends the user. It does not decide
who is denied — that is still handled by Drupal's normal permissions and access
checks. Enabling it will not grant or restrict access to any content.
