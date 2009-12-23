Outfox README
=============

Outfox is a command line application for parsing bank statements in pdf format and producing ofx files that are usable with financial applications such as wesabe.com. The impetus for this application is that some banks (cough *Wachovia* cough) provide historical statement data in pdf format, which of course is human-readable, but almost useless beyond that. I wanted to upload a couple years worth of historical statement data into wesabe, and all I had was these pdfs.

At this point, the application only supports Wachovia checking statements. At some point, it'd be nice to support other banks and statement types, but I make no promises.

Running specs and features
--------------------------

To run the specs and features

* Copy `spec/config/account_info_example.yml` to `spec/config/account_info.yml` and enter the real account information.
* Put your bank statement in spec/fixtures and name it `"#{bank_name}_#{account_type}_statement.pdf"`

Both `spec/config/account_info.yml` and `spec/config/"#{account_type}_statement.pdf"` are setup to be ignored by git.

Copyright (c) 2009 TJ Stankus. See LICENSE for details.
