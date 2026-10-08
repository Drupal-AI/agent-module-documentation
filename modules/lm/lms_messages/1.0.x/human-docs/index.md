# LMS Messages — manual setup guide

**LMS Messages** (`lms_messages`) connects the Drupal
[LMS](https://www.drupal.org/project/lms) module to the **Message** and **Message
Notify** modules, so that LMS events — enrolment, course completion, and the like
— can automatically create and send notification messages to the people involved.
It lets you configure both automatic and manual messages for LMS students and
teachers.

Mechanically, the module reacts to LMS events by **creating Message entities**
addressed to a specific recipient, and Message Notify handles delivering them.
Reading and displaying those messages is left to the Message / Message Notify
modules and their own entity access, so LMS Messages itself exposes no route that
would return message content — it plays no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Message, Message Notify, and Token.

## Configuring the notifications

LMS Messages provides a settings form (protected by the LMS module's
**Administer LMS** permission, `administer lms`) where you configure the automatic
and manual messages that go out to students and teachers for the various LMS
events. Because it builds on the Message ecosystem, the message *templates*
themselves are Message entities: you create and word them through the Message
module, use **Token** to insert dynamic values (course name, learner name, and so
on), and then wire them to LMS events from this module's form. Delivery is handled
by Message Notify.

## An important compatibility note

If the **Group Membership** module is installed, the automatic messaging can keep
failing and the module will not work as expected until an upstream Group
Membership Request issue is resolved (a patch is already included with this
module). If you use Group Membership alongside LMS Messages, be aware of this and
make sure the included patch is applied.

This is a **1.0.0-alpha5** release, so treat it as early software.
