<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file in the
     main toolkit package for applicable licenses.-->
<!-- (C) Copyright IBM Corporation 2006 All Rights Reserved. -->

<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- XHTML output with XML syntax -->
<xsl:output method="xml"
            encoding="utf-8"
            indent="no"
/>

<!-- == REFERENCE UNIQUE SUBSTRUCTURES == -->
<xsl:template name="libraryGetString">
  <xsl:param name="stringName"/>
  <xsl:call-template name="getString">
    <xsl:with-param name="stringFileList">../../demo/music/xsl/musicstrings.xml</xsl:with-param>
    <xsl:with-param name="stringName" select="$stringName"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="*[contains(@class,' songLibrary/songList ')]" name="songList">
  <h3>
    <xsl:call-template name="musicGetString">
      <xsl:with-param name="stringName" select="'My Songs'"/>
    </xsl:call-template>
  </h3>
  <xsl:call-template name="topic.simpletable"/>
</xsl:template>

<xsl:template name="artistHeader">
  <th valign="bottom"><xsl:call-template name="th-align"/>
    <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/>-artist</xsl:attribute>
    <xsl:call-template name="musicGetString"><xsl:with-param name="stringName" select="'Artist'"/></xsl:call-template>
  </th><xsl:value-of select="$newline"/>
</xsl:template>
<xsl:template name="songTitleHeader">
  <th valign="bottom"><xsl:call-template name="th-align"/>
    <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/>-songtitle</xsl:attribute>
    <xsl:call-template name="musicGetString"><xsl:with-param name="stringName" select="'Song Title'"/></xsl:call-template>
  </th><xsl:value-of select="$newline"/>
</xsl:template>
<xsl:template name="albumHeader">
  <th valign="bottom"><xsl:call-template name="th-align"/>
    <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/>-album</xsl:attribute>
    <xsl:call-template name="musicGetString"><xsl:with-param name="stringName" select="'Album'"/></xsl:call-template>
  </th><xsl:value-of select="$newline"/>
</xsl:template>
<xsl:template name="genreHeader">
  <th valign="bottom"><xsl:call-template name="th-align"/>
    <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/>-genre</xsl:attribute>
    <xsl:call-template name="musicGetString"><xsl:with-param name="stringName" select="'Genre'"/></xsl:call-template>
  </th><xsl:value-of select="$newline"/>
</xsl:template>
<xsl:template name="inPlaylistHeader">
  <th valign="bottom"><xsl:call-template name="th-align"/>
    <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/>-inPlaylist</xsl:attribute>
    <xsl:call-template name="musicGetString"><xsl:with-param name="stringName" select="'In Playlist'"/></xsl:call-template>
  </th><xsl:value-of select="$newline"/>
</xsl:template>


<xsl:template match="*[contains(@class,' songLibrary/songHeaders ')]" name="songHeaders">
  <xsl:param name="width-multiplier"/>
  <tr>
   <xsl:call-template name="setid"/>
   <xsl:call-template name="commonattributes"/>
   <xsl:value-of select="$newline"/>
   <!-- For each of the entry types: If the entry is in this row, apply-templates.
        Otherwise, if it is ever in this table, create empty entry, and add ID for accessibility. -->
   <xsl:choose>      
     <xsl:when test="*[contains(@class,' songLibrary/artistHeader ')]">
       <xsl:apply-templates select="*[contains(@class,' songLibrary/artistHeader ')]">
         <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
       </xsl:apply-templates>
     </xsl:when>
     <xsl:otherwise><xsl:call-template name="artistHeader"/></xsl:otherwise>
   </xsl:choose>
   <xsl:choose>
     <xsl:when test="*[contains(@class,' songLibrary/songTitleHeader ')]">
       <xsl:apply-templates select="*[contains(@class,' songLibrary/songTitleHeader ')]">
         <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
       </xsl:apply-templates>
     </xsl:when>
     <xsl:otherwise><xsl:call-template name="songTitleHeader"/></xsl:otherwise>
   </xsl:choose>
   <xsl:choose>      
     <xsl:when test="*[contains(@class,' songLibrary/albumHeader ')]">
       <xsl:apply-templates select="*[contains(@class,' songLibrary/albumHeader ')]">
         <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
       </xsl:apply-templates>
     </xsl:when>
     <xsl:when test="following-sibling::*/*[contains(@class,' songLibrary/album ')]">
       <xsl:call-template name="albumHeader"/>
     </xsl:when>
   </xsl:choose>
   <xsl:choose>      
     <xsl:when test="*[contains(@class,' songLibrary/genreHeader ')]">
       <xsl:apply-templates select="*[contains(@class,' songLibrary/genreHeader ')]">
         <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
       </xsl:apply-templates>
     </xsl:when>
     <xsl:when test="following-sibling::*/*[contains(@class,' songLibrary/genre ')]">
       <xsl:call-template name="genreHeader"/>
     </xsl:when>
   </xsl:choose>
   <xsl:choose>      
     <xsl:when test="*[contains(@class,' songLibrary/inPlaylistHeader ')]">
       <xsl:apply-templates select="*[contains(@class,' songLibrary/inPlaylistHeader ')]">
         <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
       </xsl:apply-templates>
     </xsl:when>
     <xsl:when test="following-sibling::*/*[contains(@class,' songLibrary/inPlaylist ')]">
       <xsl:call-template name="inPlaylistHeader"/>
     </xsl:when>
   </xsl:choose>
   <xsl:apply-templates select="*[contains(@class,' songLibrary/songInfoHeader ')]">
     <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
   </xsl:apply-templates>
  </tr>
</xsl:template>

<!-- Add the headers attribute to a cell inside the music table. -->
<xsl:template name="addMusicHeaders">
  <xsl:param name="classVal"/>
  <xsl:param name="elementType"/>
  <xsl:attribute name="headers">
    <xsl:choose>
      <!-- First choice: if there is a matching cell inside a user-specified header, and it has an ID -->
      <xsl:when test="ancestor::*[contains(@class,' songLibrary/songList ')]/*[1][contains(@class,' songLibrary/songHeaders ')]/*[contains(@class,$classVal)]/@id">
        <xsl:value-of select="ancestor::*[contains(@class,' songLibrary/songList ')]/*[1][contains(@class,' songLibrary/songHeaders ')]/*[contains(@class,$classVal)]/@id"/>
      </xsl:when>
      <!-- Second choice: if there is a matching cell inside a user-specified header, use its generated ID -->
      <xsl:when test="ancestor::*[contains(@class,' songLibrary/songList ')]/*[1][contains(@class,' songLibrary/songHeaders ')]/*[contains(@class,$classVal)]">
        <xsl:value-of select="generate-id(ancestor::*[contains(@class,' songLibrary/songList ')]/*[1][contains(@class,' songLibrary/songHeaders ')]/*[contains(@class,$classVal)])"/>
      </xsl:when>
      <!-- Third choice: no user-specified header for this column. ID is based on the table's generated ID. -->
      <xsl:otherwise>
        <xsl:value-of select="generate-id(ancestor::*[contains(@class,' songLibrary/songList ')])"/>-<xsl:value-of select="$elementType"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:template>

<!-- Process a standard row in the table. Apply-templates on the entries one at a time;
     if one is missing which should be present, create an empty cell. -->
<xsl:template match="*[contains(@class,' songLibrary/cdRow ')]" name="topic.reference.songLibrary.cdRow">
  <xsl:param name="width-multiplier"/>
  <!-- If there was no header, then this is the first child of songList; create default headers -->
  <xsl:if test="not(preceding-sibling::*)">
    <tr><xsl:value-of select="$newline"/>
      <xsl:call-template name="artistHeader"/>
      <xsl:call-template name="songTitleHeader"/>
      <xsl:call-template name="albumHeader"/>
      <xsl:call-template name="genreHeader"/>
      <xsl:call-template name="inPlaylistHeader"/>
    </tr><xsl:value-of select="$newline"/>
  </xsl:if>
  <tr>
    <xsl:call-template name="setid"/>
    <xsl:call-template name="commonattributes"/>
    <xsl:value-of select="$newline"/>
      <!-- For each of the entry types:
           - If it is in this row, apply
          - Otherwise, if it is in the table at all, create empty entry -->
    <xsl:apply-templates select="*[contains(@class,' songLibrary/artist ')]">
      <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="*[contains(@class,' songLibrary/songTitle ')]">
      <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
    </xsl:apply-templates>
    <xsl:choose>      
      <xsl:when test="*[contains(@class,' songLibrary/album ')]">
        <xsl:apply-templates select="*[contains(@class,' songLibrary/album ')]">
          <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="../*/*[contains(@class,' songLibrary/album ')] | ../*[1]/*[contains(@class,' songLibrary/albumHeader ')]">
        <td>    <!-- Create an empty cell. Add accessiblity attribute. -->
          <xsl:call-template name="addMusicHeaders">
            <xsl:with-param name="classVal"> songLibrary/albumHeader </xsl:with-param>
            <xsl:with-param name="elementType">album</xsl:with-param>
          </xsl:call-template>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        </td><xsl:value-of select="$newline"/>
      </xsl:when>
    </xsl:choose>
     <xsl:choose>      
       <xsl:when test="*[contains(@class,' songLibrary/genre ')]">
         <xsl:apply-templates select="*[contains(@class,' songLibrary/genres ')]">
           <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
         </xsl:apply-templates>
       </xsl:when>
       <xsl:when test="../*/*[contains(@class,' songLibrary/genre ')] | ../*[1]/*[contains(@class,' songLibrary/genreHeader ')]">
         <td>    <!-- Create an empty cell. Add accessiblity attribute. -->
           <xsl:call-template name="addMusicHeaders">
             <xsl:with-param name="classVal"> songLibrary/genreHeader </xsl:with-param>
             <xsl:with-param name="elementType">genre</xsl:with-param>
           </xsl:call-template>
           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
         </td><xsl:value-of select="$newline"/>
       </xsl:when>
     </xsl:choose>
     <xsl:choose>      
       <xsl:when test="*[contains(@class,' songLibrary/inPlaylist ')]">
         <xsl:apply-templates select="*[contains(@class,' songLibrary/inPlaylist ')]">
           <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
         </xsl:apply-templates>
       </xsl:when>
       <xsl:when test="../*/*[contains(@class,' songLibrary/inPlaylist ')] | ../*[1]/*[contains(@class,' songLibrary/inPlaylistHeader ')]">
         <td>    <!-- Create an empty cell. Add accessiblity attribute. -->
           <xsl:call-template name="addMusicHeaders">
             <xsl:with-param name="classVal"> songLibrary/inPlaylistHeader </xsl:with-param>
             <xsl:with-param name="elementType">inPlaylist</xsl:with-param>
           </xsl:call-template>
           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
         </td><xsl:value-of select="$newline"/>
       </xsl:when>
     </xsl:choose>
     <xsl:apply-templates select="*[contains(@class,' songLibrary/songInfo ')]">
       <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
     </xsl:apply-templates>
  </tr><xsl:value-of select="$newline"/>
</xsl:template>


<xsl:template match="*[contains(@class,' songLibrary/artist ')]">
  <td><xsl:apply-templates/></td>
</xsl:template>
<xsl:template match="*[contains(@class,' songLibrary/songTitle ')]">
  <td><xsl:apply-templates/></td>
</xsl:template>
<xsl:template match="*[contains(@class,' songLibrary/album ')]">
  <td><xsl:apply-templates/></td>
</xsl:template>
<xsl:template match="*[contains(@class,' songLibrary/genre ')]">
  <td><xsl:apply-templates/></td>
</xsl:template>
<xsl:template match="*[contains(@class,' songLibrary/inPlaylist ')]">
  <td><xsl:apply-templates/></td>
</xsl:template>

<xsl:template match="*[contains(@class,' songLibrary/band ')]">
  <xsl:param name="width-multiplier">0</xsl:param>
  <xsl:apply-templates select="." mode="musicEntry">
    <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
    <xsl:with-param name="elementType">band</xsl:with-param>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[contains(@class,' songLibrary/albums ')]">
  <xsl:param name="width-multiplier">0</xsl:param>
  <xsl:apply-templates select="." mode="musicEntry">
    <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
    <xsl:with-param name="elementType">albums</xsl:with-param>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[contains(@class,' songLibrary/comments ')]">
  <xsl:param name="width-multiplier">0</xsl:param>
  <xsl:apply-templates select="." mode="musicEntry">
    <xsl:with-param name="width-multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
    <xsl:with-param name="elementType">comments</xsl:with-param>
  </xsl:apply-templates>
</xsl:template>

<!-- Template based on the stentry template in dit2htm. Only change is to add elementType
     paramenter, and call addMusicHeaders instead of output-stentry-headers. -->
<xsl:template match="*" mode="musicEntry">
  <xsl:param name="width-multiplier">0</xsl:param>
  <xsl:param name="elementType"/>
  <td valign="top">
    <xsl:call-template name="output-stentry-id"/>
    <xsl:call-template name="addMusicHeaders">
      <xsl:with-param name="classVal"> songLibrary/<xsl:value-of select="$elementType"/>Header<xsl:text> </xsl:text></xsl:with-param>
      <xsl:with-param name="elementType"><xsl:value-of select="$elementType"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="commonattributes"/>
    <xsl:variable name="localkeycol">
      <xsl:choose>
        <xsl:when test="ancestor::*[contains(@class,' topic/simpletable ')]/@keycol">
          <xsl:value-of select="ancestor::*[contains(@class,' topic/simpletable ')]/@keycol"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- Determine which column this entry is in. -->
    <xsl:variable name="thiscolnum"><xsl:value-of select="number(count(preceding-sibling::*)+1)"/></xsl:variable>
    <!-- If width-multiplier=0, then either @relcolwidth was not specified, or this is not the first
         row, so do not create a width value. Otherwise, find out the relative width of this column. -->
    <xsl:variable name="widthpercent">
      <xsl:if test="$width-multiplier != 0">
        <xsl:call-template name="get-current-entry-percentage">
          <xsl:with-param name="multiplier"><xsl:value-of select="$width-multiplier"/></xsl:with-param>
          <xsl:with-param name="entry-num"><xsl:value-of select="$thiscolnum"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <!-- If we calculated a width, create the width attribute. -->
    <xsl:if test="string-length($widthpercent)>0">
      <xsl:attribute name="width">
        <xsl:value-of select="$widthpercent"/><xsl:text>%</xsl:text>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="flagit"/>
    <xsl:call-template name="start-revflag-parent"/>
    <xsl:call-template name="start-revflag"/>
    <xsl:variable name="revtest">
      <xsl:if test="@rev and not($FILTERFILE='') and ($DRAFT='yes')"> 
        <xsl:call-template name="find-active-rev-flag">               
          <xsl:with-param name="allrevs" select="@rev"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="revtest-row">
      <xsl:if test="../@rev and not($FILTERFILE='') and ($DRAFT='yes')"> 
        <xsl:call-template name="find-active-rev-flag">               
          <xsl:with-param name="allrevs" select="../@rev"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="$thiscolnum=$localkeycol and $revtest-row=1">
      <strong><span class="{../@rev}">
<xsl:call-template name="musicentry-templates"/>
      </span></strong>
     </xsl:when>
     <xsl:when test="$thiscolnum=$localkeycol and $revtest=1">
      <strong><span class="{@rev}">
<xsl:call-template name="musicentry-templates"/>
      </span></strong>
     </xsl:when>
     <xsl:when test="$thiscolnum=$localkeycol">
      <strong>
<xsl:call-template name="musicentry-templates"/>
      </strong>
     </xsl:when>
     <xsl:when test="$revtest-row=1">
      <span class="{../@rev}">
<xsl:call-template name="musicentry-templates"/>
      </span>
     </xsl:when>
     <xsl:when test="$revtest=1">
      <span class="{@rev}">
<xsl:call-template name="musicentry-templates"/>
      </span>
     </xsl:when>
     <xsl:otherwise>
<xsl:call-template name="musicentry-templates"/>
     </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="end-revflag"/>
    <xsl:call-template name="end-revflag-parent"/>
  </td><xsl:value-of select="$newline"/>
</xsl:template>

<xsl:template name="musicentry-templates">
 <xsl:choose>
  <xsl:when test="*|text()|processing-instruction()">
   <xsl:apply-templates/>
  </xsl:when>
  <xsl:when test="@specentry">
   <xsl:value-of select="@specentry"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>  <!-- nbsp -->
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

</xsl:stylesheet>
