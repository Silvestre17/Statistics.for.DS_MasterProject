---
title: '**Título bué fixe**'
author:
  - name: 'André Silvestre'
    affil: 20240502
    main: true
  - name: 'Filipa Pereira'
    affil: 20240509
    main: true
  - name: 'Umeima Mahomed'
    affil: 20240543
    main: true
title_textsize: '100pt'
font_family: "Rasa"
titletext_fontfamily: "Rasa"
poster_height: 48in
poster_width: 36in


logoleft_name: './Logo-Nova-IMS-White.png'

primary_colour:	  "#941a00"	 # Main colour used for poster design.
secondary_colour:	"#691300"	 # Secondary colour use for poster design.
accent_colour:	  "#cc0000"	 # A third colour option for adding some "pop" to the poster colour palette.

output: 
  posterdown::posterdown_html:
    self_contained: TRUE
    pandoc_args: --mathjax
    number_sections: TRUE
    css: "SfDS_Poster_20240502.css"
bibliography: packages.bib
csl: apa.csl
link-citations: true
columnline_col: "#fff"
columnline_width: 0mm

---






# Introduction

Welcome to `posterdown` ! This is my attempt to provide a semi-smooth workflow for those who wish to take their R Markdown skills to the conference world. Most features from R Markdown are available in this package such as Markdown section notation, figure captioning, and even citations like this one [@R-rmarkdown]. The rest of this example poster will show how you can insert typical conference poster features into your own document. 

## Objectives

1. Easy to use reproducible poster design. 
2. Integration with R Markdown.
3. Easy transition from `posterdown` to `pagedown` report or manuscript documents [@R-pagedown].

# Methods

This package uses the same workflow approach as the R Markdown you know and love. Basically it goes from RMarkdown > Knitr > Markdown > Pandoc > HTML/CSS > PDF. You can even use the bibliography the same way [@R-posterdown].



Maybe you want to show off some of that fancy code you spent so much time on to make that figure, well you can do that too! Just use the `echo=TRUE` option in the r code chunk options, Figure \@ref(fig:myprettycode)!

<div class="figure" style="text-align: center">
<img src="SfDS_Poster_20240502_files/figure-html/myprettycode-1.png" alt="&lt;span class=&quot;caption-text&quot;&gt;Boxplots, message=FALSE, warning=FALSE, out.width=&quot;95%&quot;, so hot right now!&lt;/span&gt;" width="100%" />
<p class="caption">(\#fig:myprettycode)<span class="caption-text">Boxplots, message=FALSE, warning=FALSE, out.width="95%", so hot right now!</span></p>
</div>







![Animated Map](map_animation.gif){width=100%}

How about a neat table of data? See, Table \@ref(tab:iristable):




# Results

Usually you want to have a nice table displaying some important results that you have calculated. In `posterdown` this is as easy as using the `kable` table formatting you are probably use to as per typical R Markdown formatting.

You can reference tables like so: Table \@ref(tab:mytable). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam placerat augue at velit tincidunt semper. Donec elementum porta posuere. Nullam interdum, odio at tincidunt feugiat, turpis nisi blandit eros, eu posuere risus felis non quam. Nam eget lorem odio. Duis et aliquet orci. Phasellus nec viverra est.

<table>
<caption>(\#tab:unnamed-chunk-5)Results of Statistical Tests</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Test </th>
   <th style="text-align:center;"> P_Value </th>
   <th style="text-align:center;"> H0 </th>
   <th style="text-align:center;"> Conclusion </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Robust Hausman </td>
   <td style="text-align:center;"> 0.9976 </td>
   <td style="text-align:center;"> use random effects </td>
   <td style="text-align:center;"> use random effects </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Breusch Pagan (Pooled OLS, Homosk.) </td>
   <td style="text-align:center;"> 4.52e-136 </td>
   <td style="text-align:center;"> Homosk. </td>
   <td style="text-align:center;"> Heterosk. </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Breusch Pagan (FE, Homosk.) </td>
   <td style="text-align:center;"> 4.52e-136 </td>
   <td style="text-align:center;"> Homosk. </td>
   <td style="text-align:center;"> Heterosk. </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Breusch Pagan (RE, Homosk.) </td>
   <td style="text-align:center;"> 4.52e-136 </td>
   <td style="text-align:center;"> Homosk. </td>
   <td style="text-align:center;"> Heterosk. </td>
  </tr>
</tbody>
</table>

<table>
<caption>(\#tab:unnamed-chunk-6)Results of Statistical Models</caption>
 <thead>
  <tr>
   <th style="text-align:center;"> Model </th>
   <th style="text-align:center;"> Females </th>
   <th style="text-align:center;"> Males </th>
   <th style="text-align:center;"> Survivors </th>
   <th style="text-align:center;"> Drowning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Pooled OLS </td>
   <td style="text-align:center;"> 1.64e-163 </td>
   <td style="text-align:center;"> 1.39e-25 </td>
   <td style="text-align:center;"> 7.3e-15 </td>
   <td style="text-align:center;"> 1.38e-14 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Fixed Effects </td>
   <td style="text-align:center;"> 1.75e-163 </td>
   <td style="text-align:center;"> 6.66e-22 </td>
   <td style="text-align:center;"> 3.01e-08 </td>
   <td style="text-align:center;"> 0.000737 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Random Effects </td>
   <td style="text-align:center;"> 1.88e-175 </td>
   <td style="text-align:center;"> 4.59e-22 </td>
   <td style="text-align:center;"> 2.94e-08 </td>
   <td style="text-align:center;"> 0.000756 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Robust Pooled </td>
   <td style="text-align:center;"> 6.39e-36 </td>
   <td style="text-align:center;"> 4.41e-12 </td>
   <td style="text-align:center;"> 8.97e-09 </td>
   <td style="text-align:center;"> 1.86e-14 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Robust Fixed Effects </td>
   <td style="text-align:center;"> 9.18e-06 </td>
   <td style="text-align:center;"> 0.00767 </td>
   <td style="text-align:center;"> 0.00107 </td>
   <td style="text-align:center;"> 0.00348 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Robust Random Effects </td>
   <td style="text-align:center;"> 9.02e-06 </td>
   <td style="text-align:center;"> 0.0079 </td>
   <td style="text-align:center;"> 0.0011 </td>
   <td style="text-align:center;"> 0.00299 </td>
  </tr>
</tbody>
</table>


# Next Steps

Aliquam sed faucibus risus, quis efficitur erat. Vestibulum semper mauris quis tempus eleifend. Aliquam sagittis dictum ipsum, quis viverra ligula eleifend ut. Curabitur sagittis vitae arcu eget faucibus. In non elementum felis. Duis et aliquam nunc. Nunc pulvinar sapien nunc, vel pretium nisi efficitur in. Fusce fringilla maximus leo et maximus. Fusce at ligula laoreet, iaculis mi at, auctor odio. Praesent sed elementum justo. Aenean consectetur risus rhoncus tincidunt efficitur. Praesent dictum mauris at diam maximus maximus [@R-posterdown].

# Conclusion

Try `posterdown` out! Hopefully you like it!



# References
