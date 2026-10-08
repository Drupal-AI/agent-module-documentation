# Configuration

Smashing Invoice is set up by working through a short sequence of admin forms, all
linked from the index page at **`invoice/links`** (the **Invoice service** toolbar
item). You need the **administer smashing_invoice** permission to reach any of them.

## The setup workflow

1. **Organization info** — start here. Add your organization's name, address, bank
   account number, IFSC, PAN, GSTIN, and logo. This is the "bill from" side of every
   invoice and supplies the bank details printed on the PDF. Only the first
   organization record is used by the invoice and display pages, so treat it as your
   single company profile; you can edit it later. Phone fields are validated to ten
   digits and the website field is validated as a URL.
2. **Clients** — add each client with their details (PAN/TIN, GSTIN, address, and
   contact information), and edit or list them as needed.
3. **Employees** — add the employees you invoice for, and edit or list them.
4. **Allocations** — tie an employee to a client at a **per-hour or per-month
   price**. The allocations for a given client are shown together, and you can edit
   an allocation later.
5. **Generate an invoice** — choose **hour-based** or **month-based**, and the
   module computes the amount from the days or hours worked and the allocated price,
   applying **18% IGST** when GST is enabled. The invoice shows a "Bill to" / "Bill
   from" tax-invoice layout with your organization's logo and bank details.
6. **Invoices** — the generated invoices are listed with client names, each with a
   **Download** link that produces the PDF (rendered via the TCPDF library).

## Data access notes

- **Financial PII.** The organization record stores bank account number, IFSC, PAN,
  and GSTIN, and clients carry tax identifiers. All of this is readable and
  downloadable by anyone with the single **administer smashing_invoice** permission —
  there is no per-record ownership. Keep the permission scoped to trusted staff only.

## After setup

Once your organization info, clients, employees, and allocations are in place, you
can generate and download invoices any time from `invoice/links`, and update the
organization information whenever your bank or tax details change.
