
This section describes the XML format you should use when importing text using the [Sparv corpus pipeline](https://spraakbanken.gu.se/eng/research/infrastructure/sparv/distribution/pipeline).

### Format requirements

The input text files must meet the following criteria:

* The files must be encoded in **UTF-8**.
* The format must be **valid XML**, *with the following two exceptions*:  
    1. No root element is needed. It is however required that all text in the file must be contained within elements.  
The simplest valid file possible consists of a single element, for example `<text>`, containing nothing but raw text.  
    2. Overlapping elements are allowed (`<a><b></a></b>`).
* No file should be larger than **~10-20 MB**, or you might run into memory problems. Split too large files into smaller files.

### Metadata

Any metadata about the text as a whole or parts of the text (e.g. chapters, sentences, words) must exist in the form of attributes to the
elements containing the text. For example:

    <text title="Title metadata here">
      This is the corpus text.
    </text>

*All text*, except for element attributes, will be part of the corpus text, and will not be treated as metadata. The following example
is *not* a valid way to set title metadata for a text, and the string "Title metadata here" will be treated as corpus text:

    <text>
      <title>Title metadata here</title>
      This is the corpus text.
    </text>

#### Headers

One exception to the above is when there is a header in the file, such as:

    <text>
      <header>
        <title>Title metadata here</title>
      </header>
      This is the corpus text.
    </text>

In this case it is possible to treat the whole `header` element (not necessarily named `header`) as not belonging to the text, and instead extract metadata from it. The
metadata will be tied to all text contained by the root element. In this case the root element is `text`, and the result will be the same as in the first example.

The following is *not* a valid example where you can extract header metadata, due to the header being disconnected from the text:

    <header>
      <title>Title metadata here</title>
    </header>
    <text>
      This is the corpus text.
    </text>

However, had both `header` and `text` been contained within another element, header metadata extraction would have been possible.

### Configuring the Makefile

When using the corpus pipeline you configure your Makefile to match your XML format, and tell it what elements and attributes to parse.
The variables used for this are the following:

    xml_elements
    xml_annotations

In `xml_elements` you list (in lowercase, separated by whitespace) the elements of interest, optionally with their attributes (on the form `element:attribute`).
`xml_annotations` is a list of the same size, with every item corresponding to an item in `xml_elements`. This list contains the names of
the annotation files that will be created during parsing. For example:

    xml_elements =    text:title  text:author  s
    xml_annotations = text.title  text.author  sentence

The above will parse elements such as `<text title="X" author="Y">` and save title and author as separate annotations. It will also parse the
attribute `<s>`, not saving any attribute data but only the boundaries of the element, marking the beginning and end of every sentence (provided
that our example text has sentence segmentation marked with `<s>` tags).
In this way you can use existing annotations of a material during the import, rather than letting the pipeline create new annotations for you.
By saving the `<s>` element as the annotation named `sentence`, the pipeline will not try to create that annotation itself. There are several
hardcoded annotation names, all of which can be overridden like `sentence` above:

    Positional: token.pos, token.msd, token.baseform, token.lemgram, token.saldo, token.prefix, token.suffix
    Structural: token, sentence, paragraph

For positional annotations (annotations for single tokens), use the prefix "token." as shown above.

You can combine several elements into one annotation, if for example sentence segmentation is marked up with `<s>` in some places and `<x>` in some.
Combining them is done by simply joining both elements with a "+":

    xml_elements =    s+x
    xml_annotations = sentence

#### Headers

For files containing headers like in the previously shown example, three variables has to be set in the Makefile:

    xml_header
    xml_headers
    xml_header_annotations

The first one should be set to the name of the header element, in lowercase. This tells the parser that this element is a header, and none of its
text content will be part of the corpus text.

    xml_header = header

Alternatively you can give the full path to the header, joining elements by ".":

    xml_header = text.header

The second and third variable is similar to the `xml_elements`/`xml_annotations` pair. The first one is a list of headers to parse,
and the second a list of corresponding annotation files that will be created:

    xml_headers
    xml_header_annotations

`xml_headers` must contain the full path to the element in question, in lowercase. As with `xml_elements` you can specify attributes using a colon, but it is
also possible to parse the text contained by the element, by using the keyword "TEXT" instead of an attribute:

    xml_headers            = text.header.title:TEXT
    xml_header_annotations = text.title

Any periods in element names have to be escaped using backslash.

### An example

The following is an example input file, with existing sentence segmentation and tokenization. Every token is annotated with its baseform.

    <text title="Test">
      <s>
        <w bf="it">It</w>
        <w bf="be">was</w>
        <w bf="an">an</w>
        <w bf="elephant">elephant</w>
        <w bf=".">.</w>
      </s>
    </text>

The configuration of the Makefile will look like this:

    xml_elements =    text:title  s         w      w:bf
    xml_annotations = text.title  sentence  token  token.baseform
