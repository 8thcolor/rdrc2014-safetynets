# RDRC 2014: Safety Nets: learn to code with confidence

This repository contains the code illustrating the talk given by me
(Christophe Philemotte) at RedDotRubyConference 2014: Safety Nets: Learn to
code with confidence.

Each commit corresponds to a step in the illustration and will allow you to
reproduce it step by step.

## A simple invoicing application

As illustration, we'll implement a simple invoicing application. This is a
common use case that everybody should easily relate to. Please consider that
it's not a real application. It's oversimplified as the goal is to support the
concept of safety nets without digging too deep in each kind of. As
consequence, some design could be certainly be improved.

## Test

### A simple invoice

An invoice is composed of several items in a certain quantity and with a
certain price. You can add an item to an invoice. You can get the total
of an invoice.

### Promote total local variable to member attribute

Then, we think it would be better to make total local variable a member
attribute.

But the test fails. We miss something when doing the change.

```
  1) Failure:
Invoice#test_0003_returns a correct total even after updating a previously added item [spec/invoice_spec.rb:30]:
Expected: 105
  Actual: 195.0
```

### Fix the failure

We miss to reset the total before calculate it. By doing it, the tests then
pass again.

## Static Analysis

### Manage European VAT

Then, as the invoice application is mainly used by Europeans, we decide to
manage VAT. We add then the necessary logic for: we need a country code and a
VAT rate.
