<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Send To Phone is a submodule of SMS Framework. It lets users text a piece of content — a node's link, a text field's value, or text marked with `[sms]…[/sms]` — to a phone number through a shared send form.

---

Send To Phone is about sharing small bits of content by SMS. On enabled content types a "Send to phone" link appears on the node; a text-field formatter ("SMS Link") and a matching widget add the same link beside field values; and an "Inline SMS" text-format filter turns `[sms]…[/sms]` markup into a highlighted send link. Each opens one send form at `/sms/sendtophone/{type}/{extra}` that pre-fills the message (a node URL, or the passed text) and asks for a phone number, then queues an outgoing message through the parent SMS Framework and its configured gateway. An admin form under the SMS Framework settings chooses which content types show the node link. The `send to any number` permission is meant to distinguish users who may text arbitrary numbers from those who should only text their own confirmed number. It has no gateway or queue settings of its own — those come from SMS Framework.

---

- Add a "Send to phone" link to articles or pages.
- Let readers text a node's link to their phone.
- Text a text-field value to a phone number.
- Add an SMS Link formatter to a text field's display.
- Use the SMS send widget on a text field form.
- Mark inline text with [sms]…[/sms] to make it textable.
- Send a page URL to a phone for reading later.
- Text an address or phone snippet to a mobile.
- Choose which content types expose the send link.
- Restrict arbitrary-number sending with a permission.
- Let signed-in users send content to their own number.
- Prompt users to confirm a mobile number before sending.
- Share an event's node link by SMS.
- Text directions or a location snippet to a phone.
- Send a coupon code or short note to a mobile.
- Provide a share-by-SMS option alongside share buttons.
