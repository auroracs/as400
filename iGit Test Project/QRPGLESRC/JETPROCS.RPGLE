000100151228      /If not Defined(CopyJETPrototype)
000200151125
000300151125     H NoMain Option(*NoDebugIO) DatFmt(*YMD) Thread(*serialize)
000400140307     /* ?**********************************************************? */
000500151228     /* ?SOURCE       -  JETPROCS                                  ? */
000600151110     /* ?PROGRAMMER   -  Jim Engle - Tree Line Data, LLC.          ? */
000700151228     /* ?DATE         -  12-28-2015                                ? */
000800151228     /* ?COMMENTS     -  Common processes used by Jet.com APIs     ? */
000900151125     /* ?                                                          ? */
001000151125     /* ?HOW TO COMPILE:                                           ? */
001100151125     /* ?                                                          ? */
001200151125     /* ?1. Create the module:                                     ? */
001300151228     /* ?   crtrpgmod module(JETPROCS) srcfile(lib/QRPGLESRC)      ? */
001400151125     /* ?                                                          ? */
001500151125     /* ?2. Create the service program:                            ? */
001600151228     /* ?   crtsrvpgm srvpgm(JETPROCS) export(*all) actgrp(JETPROCS) */
001700151125     /* ?                                                          ? */
001800140307     /* ?**********************************************************? */
001900140307     /* ?                MODIFICATIONS                             ? */
002000140307     /* ?**********************************************************? */
002100140307     /* ?Date       Init Description                               ? */
002200140307     /* ?---------- ---- ----------------------------------------  ? */
002300151228     /* ?12/28/15   Jim  Started program                           ? */
002400140307     /* ?**********************************************************? */
002500140305
002600151228      //?Valid sites file               ?
002700160103     fprcsitep  if   e           k disk    usropn
002800140312
002900151228      //?URI file that contains base URI
003000160103     fjeturlp   if   e           k disk    usropn
003100151127
003200160215      //?Item extention file for web site content
003300160215     fitmwebl1  if   e           k disk    usropn
003400151228
003500160104      //?Zipcode Master
003600160104     fzipmstp   if   e           k disk    usropn
003700160104
003800160104      //?Jet Credentials file
003900160104     fjetcrdp   if   e           k disk    usropn
004000160104
004100160104      //?Price Alert file
004200160104     fprcalertp if   e           k disk    usropn
004300160104
004400160107      //?Interface JAR file
004500160107     fintjarp   if   e           k disk    usropn
004600160107
004700160211      //?Jet Valid SKU file
004800160211     fjetskuuplpif   e           k disk    usropn
004900160211
005000151228      //?Standalone work fields and constants
005100151228     d @validSite      s               n   inz
005200151228     d @validFunction  s               n   inz
005300151228     d @validOrdStats  s               n   inz
005400160114     d @validRetStats  s               n   inz
005500151228     d @validSKUStats  s               n   inz
005600151228     d @validSKU       s               n   inz
005700151228     d @validNumber    s               n   inz
005800151228     d returnURI       s            500a   inz
005900160104     d retEstDelDat    s             10a   inz
006000160104     d returnDays      s              3a   inz
006100160104     d returnASIN      s             20a   inz
006200160105     d returnCreds     s            150a   inz
006300160106     d return500       s            500a   inz
006400160204     d return30000     s          30000a   inz
006500160107     d retClassLib     s            500a   inz
006600151228     d upper           c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
006700151228     d lower           c                   'abcdefghijklmnopqrstuvwxyz'
006800000000
006900140312      * ?Local data area
007000140312     d               euds                  extname(ldadefp)
007100140312
007200140312      * ?Program information data structure
007300140312     d               esds                  extname(pgmsts)
007400140312
007500151125      /endif
007600151125
007700151228     ?*  JETPROCS Prototypes
007800151125
007900151228     ?*  Prototype to validate site code
008000151228     d ValidSite...
008100151228     d                 pr              n
008200151125     d #cmpy                          3a   const
008300151228     d #site                          4a   const
008400151111
008500151228     ?*  Prototype to validate API function
008600151228     d ValidFunction...
008700151228     d                 pr              n
008800151128     d #cmpy                          3a   const
008900151228     d #site                          4a   const
009000151228     d #function                     15a   const
009100151128
009200151228     ?*  Prototype to validate order status
009300151228     d ValidOrderStatus...
009400151228     d                 pr              n
009500151228     d #ordstatus                    15a   const
009600151128
009700160114     ?*  Prototype to validate return status
009800160114     d ValidReturnStatus...
009900160114     d                 pr              n
010000160114     d #retstatus                    25a   const
010100160114
010200151228     ?*  Prototype to validate SKU status
010300151228     d ValidSKUStatus...
010400151228     d                 pr              n
010500151228     d #skustatus                    30a   const
010600151228
010700151228     ?*  Prototype to validate SKU
010800151228     d ValidSKU...
010900151228     d                 pr              n
011000151228     d #cmpy                          3a   const
011100151228     d #site                          4a   const
011200151228     d #sku                          27a   const
011300151228
011400151228     ?*  Prototype to get URL for given cmpy/site/function
011500151228     d GetAPIURI...
011600151228     d                 pr           500a   varying
011700151228     d #cmpy                          3a   const
011800151228     d #site                          4a   const
011900151228     d #function                     15a   const
012000151228
012100151228     ?*  Prototype to UPPER case a value passed in
012200151228     d UpperCase...
012300151228     d                 pr           500a   varying
012400151228     d #lowerValue                  500a   const
012500151228
012600151228     ?*  Prototype to LOWER case a value passed in
012700151228     d LowerCase...
012800151228     d                 pr           500a   varying
012900151228     d #upperValue                  500a   const
013000151228
013100151228     ?*  Prototype to validate start point and results to return
013200151228     d ValidNumber...
013300151228     d                 pr              n
013400151228     d #number                        4a   const
013500151228
013600160104     ?*  Prototype to get Estimated delivery date
013700160104     d GetEstDelDate...
013800160104     d                 pr            10a   varying
013900160104     d #cmpy                          3a   const
014000160104     d #whse                          2p 0 const
014100160104     d #zipcode                      12a   const
014200160104     d #state                         2a   const
014300160104     d #shipDate                      8p 0 const
014400160104
014500160104     ?*  Prototype to get number returns days value
014600160104     d GetReturnDays...
014700160104     d                 pr             3a   varying
014800160104     d #cmpy                          3a   const
014900160104     d #site                          4a   const
015000160104
015100160104     ?*  Prototype to get ASIN for a SKU
015200160104     d GetASINforSKU...
015300160104     d                 pr            20a   varying
015400160104     d #cmpy                          3a   const
015500160104     d #alert                         4a   const
015600160104     d #site                          4a   const
015700160104     d #sku                          27a   const
015800160104
015900160105     ?*  Prototype to get API user and password
016000160105     d GetAPICreds...
016100160105     d                 pr           150a   varying
016200160105     d #cmpy                          3a   const
016300160105     d #site                          4a   const
016400160105
016500160106     ?*  Prototype to scan and replace a given string
016600160106     d ScanReplace...
016700160204     d                 pr         30000a   varying
016800160204     d #valueIN                   30000a   const
016900160106     d #scanValue                   100a   const
017000160106     d #replaceValue                100a   const
017100160106
017200160107     ?*  Prototype to build classlib variable for java JVM
017300160107     d BuildClassLib...
017400160107     d                 pr           500a   varying
017500160107     d #cmpy                          3a   const
017600160107     d #site                          4a   const
017700160107
017800151228      /If not Defined(CopyJETPrototype)
017900151125
018000151125      //?----------------------------------------------------------?
018100151228      //? Procedure name: ValidSite
018200151228      //?    Description: Validate site code against PRCSITEP.
018300151228      //?          Input: company, site      ?
018400151228      //?        Returns: boolean *ON if true, *OFF if false.
018500140307      //?----------------------------------------------------------?
018600000000
018700151228     P ValidSite...
018800151125     P                 B                   EXPORT
018900151228     D ValidSite...
019000151228     D                 PI              n
019100151125     d #cmpy                          3a   const
019200151228     d #site                          4a   const
019300151127
019400140307      /free
019500140312
019600160103        if not %open(prcsitep);
019700160103           open prcsitep;
019800160103        endif;
019900160103
020000151228        @validSite = *off;
020100151228
020200151228        chain (#cmpy:#site) prcsitep;
020300151228        if %found(prcsitep);
020400151228          @validSite = *on;
020500151228        endif;
020600151127
020700160103        close prcsitep;
020800160103
020900151228        return @validSite;
021000151127
021100151125      /end-free
021200151125
021300151228     PValidSite...
021400151125     P                 E
021500151125
021600151228      //?----------------------------------------------------------?
021700151228      //? Procedure name: ValidFunction
021800151228      //?    Description: Validate Function code against JETURLP.
021900151228      //?          Input: company, site, function
022000151228      //?        Returns: *ON if true, *OFF if false.
022100151228      //?----------------------------------------------------------?
022200151228
022300151228     P ValidFunction...
022400151228     P                 B                   EXPORT
022500151228     D ValidFunction...
022600151228     D                 PI              n
022700151228     d #cmpy                          3a   const
022800151228     d #site                          4a   const
022900151228     d #function                     15a   const
023000151228
023100151228      /free
023200151228
023300160103        if not %open(jeturlp);
023400160103           open jeturlp;
023500160103        endif;
023600160103
023700151228        @validFunction = *off;
023800151228
023900151228        chain (#cmpy:#site:#function) jeturlp;
024000151228        if %found(jeturlp) and status = 'A';
024100151228          @validFunction = *on;
024200151228        endif;
024300151228
024400160103        close jeturlp;
024500160103
024600151228        return @validFunction;
024700151228
024800151228      /end-free
024900151228
025000151228     PValidFunction...
025100151228     P                 E
025200151228
025300151228      //?----------------------------------------------------------?
025400151228      //? Procedure name: ValidOrderStatus
025500151228      //?    Description: Validate the status against a list of
025600151228      //?                  valid codes in this routine.
025700151228      //?          Input: status
025800151228      //?        Returns: *ON if true, *OFF if false.
025900151228      //?----------------------------------------------------------?
026000151228
026100151228     P ValidOrderStatus...
026200151228     P                 B                   EXPORT
026300151228     D ValidOrderStatus...
026400151228     D                 PI              n
026500151228     d #status                       15a   const
026600151228
026700151228      /free
026800151228
026900151228        @validOrdStats = *on;
027000151228
027100151228        // do nothing if one of these status
027200151228        // if Other, then invalid
027300151228        select;
027400151228          when #status = 'Created     ';
027500160111          when #status = 'ready       ';
027600151228          when #status = 'Acknowledged';
027700151228          when #status = 'Inprogress  ';
027800151228          when #status = 'Complete    ';
027900151228          other;
028000151228            @validOrdStats = *off;
028100151228        endsl;
028200151228
028300151228        return @validOrdStats;
028400151228
028500151228      /end-free
028600151228
028700151228     PValidOrderStatus...
028800151228     P                 E
028900151228
029000151228      //?----------------------------------------------------------?
029100151228      //? Procedure name: ValidSKUStatus
029200151228      //?    Description: Validate a SKU status against the list
029300151228      //?                  of valid status in this routine.
029400151228      //?          Input: status
029500151228      //?        Returns: *ON if true, *OFF if false.
029600151228      //?----------------------------------------------------------?
029700151228
029800151228     P ValidSKUStatus...
029900151228     P                 B                   EXPORT
030000151228     D ValidSKUStatus...
030100151228     D                 PI              n
030200151228     d #status                       30a   const
030300151228
030400151228      /free
030500151228
030600151228        @validSKUStats = *on;
030700151228
030800151228        // do nothing if one of these status
030900151228        // if Other, then invalid
031000151228        select;
031100151228          when #status = 'Under Jet Review             ';
031200151228          when #status = 'Missing Listing Data         ';
031300151228          when #status = 'Available for Purchase       ';
031400151228          when #status = 'Archived                     ';
031500151228          when #status = 'Excluded                     ';
031600151228          when #status = 'Unauthorized                 ';
031700151228          when #status = 'Additional SKU ID needed     ';
031800151228          when #status = 'Incorrect multipack quantity ';
031900151228          when #status = 'Invalid category             ';
032000151228          when #status = 'Invalid SKU identifier       ';
032100151228          when #status = 'Missing attribute value      ';
032200151228          when #status = 'Missing brand                ';
032300151228          when #status = 'Missing category             ';
032400151228          when #status = 'Missing image                ';
032500151228          when #status = 'Missing price                ';
032600151228          when #status = 'Missing shipping weight      ';
032700151228          when #status = 'Missing variation information';
032800151228          other;
032900151228            @validSKUStats = *off;
033000151228        endsl;
033100151228
033200151228        return @validSKUStats;
033300151228
033400151228      /end-free
033500151228
033600151228     PValidSKUStatus...
033700151228     P                 E
033800151128
033900151228      //?----------------------------------------------------------?
034000151228      //? Procedure name: GetAPIURI
034100151228      //?    Description: Get the URI needed for select API
034200151228      //?          Input: Company code, site and functions      ?
034300151228      //?        Returns: URI to be used in call to API
034400151228      //?----------------------------------------------------------?
034500151228
034600151228     P GetAPIURI...
034700151228     P                 B                   EXPORT
034800151228     D GetAPIURI...
034900151228     D                 PI           500a   varying
035000151228     d #cmpy                          3a   const
035100151228     d #site                          4a   const
035200151228     d #function                     15a   const
035300151228
035400151228      /free
035500151228
035600160103           if not %open(jeturlp);
035700160103              open jeturlp;
035800160103           endif;
035900160103
036000151228           chain (#cmpy:#site:#function) jeturlp;
036100151228           if %found(jeturlp) and status = 'A';
036200151228              returnURI = URL;
036300151228           endif;
036400151228
036500160103           close jeturlp;
036600160103
036700151228           return returnURI;
036800151228
036900151228      /end-free
037000151228
037100151228     PGetAPIURI...
037200151228     P                 E
037300151228
037400151228      //?----------------------------------------------------------?
037500151228      //? Procedure name: UpperCase
037600151228      //?    Description: Translate value passed in to UPPER case
037700151228      //?          Input: Value to translate ?
037800151228      //?        Returns: UPPER case value
037900151228      //?----------------------------------------------------------?
038000151228
038100151228     P UpperCase...
038200151228     P                 B                   EXPORT
038300151228     D UpperCase...
038400151228     D                 PI           500a   varying
038500151228     d #lowerValue                  500a   const
038600151228
038700151228      /free
038800151228
038900151228           returnURI = %xlate(lower:upper:#lowerValue);
039000151228
039100151228           return returnURI;
039200151228
039300151228      /end-free
039400151228
039500151228     PUpperCase...
039600151228     P                 E
039700151228
039800151228      //?----------------------------------------------------------?
039900151228      //? Procedure name: LowerCase
040000151228      //?    Description: Translate value passed in to lower case
040100151228      //?          Input: Value to translate ?
040200151228      //?        Returns: lower case value
040300151228      //?----------------------------------------------------------?
040400151228
040500151228     P LowerCase...
040600151228     P                 B                   EXPORT
040700151228     D LowerCase...
040800151228     D                 PI           500a   varying
040900151228     d #upperValue                  500a   const
041000151228
041100151228      /free
041200151228
041300151228           returnURI = %xlate(upper:lower:#upperValue);
041400151228
041500151228           return returnURI;
041600151228
041700151228      /end-free
041800151228
041900151228     PLowerCase...
042000151228     P                 E
042100151228
042200151228      //?----------------------------------------------------------?
042300151228      //? Procedure name: ValidSKU
042400151228      //?    Description: Validates the sku against the item cross
042500160211      //?                  reference file and the SKU upload driver.
042600151228      //?          Input: company, site, SKU ?
042700151228      //?        Returns: *ON if true, *OFF if false.
042800151228      //?----------------------------------------------------------?
042900151228
043000151228     P ValidSKU...
043100151228     P                 B                   EXPORT
043200151228     D ValidSKU...
043300151228     D                 PI              n
043400151228     d #cmpy                          3a   const
043500151228     d #site                          4a   const
043600151228     d #sku                          27a   const
043700151228
043800151228      /free
043900151228
044000160215        if not %open(itmwebl1);
044100160215           open itmwebl1;
044200160103        endif;
044300160103
044400160211        if not %open(jetskuuplp);
044500160211           open jetskuuplp;
044600160211        endif;
044700160211
044800151228        @validSKU = *off;
044900151228
045000160215        setll (#cmpy:#sku:#site) itmwebl1;
045100160215        if %equal(itmwebl1);
045200160211           setll (#cmpy:#site:#sku) jetskuuplp;
045300160211           if %equal(jetskuuplp);
045400160211             @validSKU = *on;
045500160211           endif;
045600160211        endif;
045700151228
045800160215        close itmwebl1;
045900160211        close jetskuuplp;
046000160103
046100151228        return @validSKU;
046200151228
046300151228      /end-free
046400151228
046500151228     PValidSKU...
046600151228     P                 E
046700151228
046800151228      //?----------------------------------------------------------?
046900151228      //? Procedure name: ValidNumber
047000151228      //?    Description: Validates start point # and results to
047100151228      //?                  return number. Valid number from 1-9999
047200151228      //?          Input: number ?
047300151228      //?        Returns: *ON if true, *OFF if false.
047400151228      //?----------------------------------------------------------?
047500151228
047600151228     P ValidNumber...
047700151228     P                 B                   EXPORT
047800151228     D ValidNumber...
047900151228     D                 PI              n
048000151228     d #number                        4a   const
048100151228
048200151228     d @number         s              5p 0 inz
048300151228
048400151228      /free
048500151228
048600151228        @validNumber = *on;
048700151228
048800151228        monitor;
048900151228          @number = %dec(%trim(#number):4:0);
049000151228        on-error;
049100151228          @validNumber = *off;
049200151228        endmon;
049300151228
049400151228        return @validNumber;
049500151228
049600151228      /end-free
049700151228
049800151228     PValidNumber...
049900151228     P                 E
050000151228
050100160104      //?----------------------------------------------------------?
050200160104      //? Procedure name: GetEsDelDate
050300160104      //?    Description: Get the Estimated Delivery date
050400160104      //?          Input: Company, warehouse, ship-to zip & state
050500160104      //?        Returns: 10 character date
050600160104      //?----------------------------------------------------------?
050700160104
050800160104     P GetEstDelDate...
050900160104     P                 B                   EXPORT
051000160104     D GetEstDelDate...
051100160104     D                 PI            10a   varying
051200160104     d #cmpy                          3a   const
051300160104     d #whse                          2p 0 const
051400160104     d #zip                          12a   const
051500160104     d #state                         2a   const
051600160104     d #ordDate                       8p 0 const
051700160104
051800160104      * ?DS for estimating delivery date
051900160104     d                 ds
052000160104     d @zmpckp                        3  0                                      zipmstp
052100160104     d  days2del                      1  0 overlay(@zmpckp:2)
052200160104
052300160104     d                 ds
052400160104     d @zipa                         12                                         zipmstp
052500160104     d  @zip5                         5    overlay(@zipa)
052600160104     d  @zblanks                      7    overlay(@zipa:6)
052700160104
052800160104     d shipDate        s               d   inz
052900160104
053000160104      /free
053100160104
053200160104           if not %open(zipmstp);
053300160104              open zipmstp;
053400160104           endif;
053500160104
053600160104           @zblanks = *blanks;
053700160104           @zipa = #zip;
053800160104           chain (#cmpy:#whse:#zip:#state) zipmstp;
053900160104           if not %found(zipmstp);
054000160104              days2del = 2; // default to 2 days if no zipmstp rec
054100160104           endif;
054200160104
054300160104           @zmpckp = zmpckp;
054400160104
054500160104           monitor;
054600160104              shipDate = %date(#ordDate:*usa);
054700160104           on-error;
054800160104              return 'Inv Date  ';
054900160104           endmon;
055000160104
055100160104           //?add # of days to deliver
055200160104           shipDate += %days(days2del);
055300160104
055400160104           //?convert back to char est. delivery date
055500160104           retEstDelDat = %char(shipDate:*usa/);
055600160104
055700160104           close zipmstp;
055800160104
055900160104           return retEstDelDat;
056000160104
056100160104      /end-free
056200160104
056300160104     PGetEstDelDate...
056400160104     P                 E
056500160104
056600160104      //?----------------------------------------------------------?
056700160104      //? Procedure name: GetReturnDays
056800160104      //?    Description: Get the number of days to return value
056900160104      //?          Input: Company, site
057000160104      //?        Returns: Number of days to return item
057100160104      //?----------------------------------------------------------?
057200160104
057300160104     P GetReturnDays...
057400160104     P                 B                   EXPORT
057500160104     D GetReturnDays...
057600160104     D                 PI             3a   varying
057700160104     d #cmpy                          3a   const
057800160104     d #site                          4a   const
057900160104
058000160104      /free
058100160104
058200160104           if not %open(jetcrdp);
058300160104              open jetcrdp;
058400160104           endif;
058500160104
058600160104           returnDays = *blanks;
058700160104
058800160104           chain (#cmpy:#site) jetcrdp;
058900160104           if %found(jetcrdp);
059000160104              returnDays = RTNDAYS;
059100160104           endif;
059200160104
059300160104           close jetcrdp;
059400160104
059500160104           return returnDays;
059600160104
059700160104      /end-free
059800160104
059900160104     PGetReturnDays...
060000160104     P                 E
060100160104
060200160104      //?----------------------------------------------------------?
060300160104      //? Procedure name: GetASINforSKU
060400160104      //?    Description: Get the ASIN for a SKU
060500160104      //?          Input: Company, alert, site, SKU
060600160104      //?        Returns: ASIN for given SKU
060700160104      //?----------------------------------------------------------?
060800160104
060900160104     P GetASINforSKU...
061000160104     P                 B                   EXPORT
061100160104     D GetASINforSKU...
061200160104     D                 PI            20a   varying
061300160104     d #cmpy                          3a   const
061400160104     d #alert                         4a   const
061500160104     d #site                          4a   const
061600160104     d #sku                          27a   const
061700160104
061800160104      /free
061900160104
062000160104           if not %open(prcalertp);
062100160104              open prcalertp;
062200160104           endif;
062300160104
062400160104           returnASIN = *blanks;
062500160104
062600160104           chain (#cmpy:#alert:#site:#sku) prcalertp;
062700160104           if %found(prcalertp);
062800160104              returnASIN = PAASIN;
062900160104           endif;
063000160104
063100160104           close prcalertp;
063200160104
063300160104           return returnASIN;
063400160104
063500160104      /end-free
063600160104
063700160104     PGetASINforSKU...
063800160104     P                 E
063900160104
064000160105      //?----------------------------------------------------------?
064100160105      //? Procedure name: GetAPICreds
064200160105      //?    Description: Get the user and password for API calls
064300160105      //?          Input: Company, site
064400160105      //?        Returns: User and password from JETCRDP
064500160105      //?----------------------------------------------------------?
064600160105
064700160105     P GetAPICreds...
064800160105     P                 B                   EXPORT
064900160105     D GetAPICreds...
065000160105     D                 PI           150a   varying
065100160105     d #cmpy                          3a   const
065200160105     d #site                          4a   const
065300160105
065400160105      * ?DS to return back to caller
065500160105     d                 ds
065600160105     d returnCreds                  150a
065700160105     d  returnUser                   50a   overlay(returnCreds:1)
065800160105     d  returnPass                   50a   overlay(returnCreds:51)
065900160105     d  returnMerch                  50a   overlay(returnCreds:101)
066000160105
066100160105      /free
066200160105
066300160105           if not %open(jetcrdp);
066400160105              open jetcrdp;
066500160105           endif;
066600160105
066700160105           returnCreds = *blanks;
066800160105
066900160105           chain (#cmpy:#site) jetcrdp;
067000160105           if %found(jetcrdp);
067100160105              returnUser  = APIUSER;
067200160105              returnPass  = SECRET;
067300160105              returnMerch = MERCHID;
067400160105           endif;
067500160105
067600160105           close jetcrdp;
067700160105
067800160105           return returnCreds;
067900160105
068000160105      /end-free
068100160105
068200160105     PGetAPICreds...
068300160105     P                 E
068400160105
068500160106      //?----------------------------------------------------------?
068600160106      //? Procedure name: ScanReplace
068700160106      //?    Description: Scan for value and replace with another
068800160106      //?          Input: String to scan, value to scan for,
068900160106      //?                  and value to replace with.
069000160106      //?        Returns: New string with replaced value
069100160106      //?----------------------------------------------------------?
069200160106
069300160106     P ScanReplace...
069400160106     P                 B                   EXPORT
069500160106     D ScanReplace...
069600160204     D                 PI         30000a   varying
069700160204     d #valueIN                   30000a   const
069800160106     d #scanValue                   100a   const
069900160106     d #replaceValue                100a   const
070000160106
070100160106     D pos             s              5p 0 inz
070200160106
070300160106      /free
070400160106
070500160204           return30000 = #valueIN; // default to value sent in
070600160106           pos = 1;
070700160106           pos = %scan(%trim(#scanValue):#valueIN:pos);
070800160106           if (pos > *zero);
070900160204              return30000  = %replace( %trim(#replaceValue)
071000160106                            : #valueIN
071100160106                            : pos
071200160106                            : %len(%trim(#scanValue)));
071300160106           endif;
071400160106
071500160204           return return30000;
071600160106
071700160106      /end-free
071800160106
071900160106     PScanReplace...
072000160106     P                 E
072100160106
072200160107      //?----------------------------------------------------------?
072300160107      //? Procedure name: BuildClassLib
072400160107      //?    Description: Build CLASSLIB variable for java JVM calls
072500160107      //?          Input: Company, site
072600160107      //?        Returns: CLASSLIB variable
072700160107      //?----------------------------------------------------------?
072800160107
072900160107     P BuildClassLib...
073000160107     P                 B                   EXPORT
073100160107     D BuildClassLib...
073200160107     D                 PI           500a   varying
073300160107     d #cmpy                          3a   const
073400160107     d #site                          4a   const
073500160107
073600160107     D fldName         s             20a   inz
073700160107
073800160107      /free
073900160107
074000160107           if not %open(intjarp);
074100160107              open intjarp;
074200160107           endif;
074300160107
074400160107           retClassLib = *blanks;
074500160107
074600160107           setll (#cmpy:#site) intjarp;
074700160107           reade (#cmpy:#site) intjarp;
074800160107
074900160107           // capture folder name. on needed on first successful read
075000160107           if not %eof(intjarp) and STATUS = 'A';
075100160107              retClassLib = '/' + %trim(IFSFLDR) + '/';
075200160107           endif;
075300160107
075400160107           dow not %eof(intjarp);
075500160107              if STATUS = 'A';
075600160107                 retClassLib = %trim(retClassLib) +
075700160107                            ':/' + %trim(IFSFLDR) +
075800160107                            '/' + %trim(JARFILE);
075900160107              endif;
076000160107              reade (#cmpy:#site) intjarp;
076100160107           enddo;
076200160107
076300160107           retClassLib = %trim(retClassLib) + ':';
076400160107
076500160107           close intjarp;
076600160107
076700160107           return retClassLib;
076800160107
076900160107      /end-free
077000160107
077100160107     PBuildClassLib...
077200160107     P                 E
077300160107
077400160114      //?----------------------------------------------------------?
077500160114      //? Procedure name: ValidReturnStatus
077600160114      //?    Description: Validate the status against a list of
077700160114      //?                  valid codes in this routine.
077800160114      //?          Input: status
077900160114      //?        Returns: *ON if true, *OFF if false.
078000160114      //?----------------------------------------------------------?
078100160114
078200160114     P ValidReturnStatus...
078300160114     P                 B                   EXPORT
078400160114     D ValidReturnStatus...
078500160114     D                 PI              n
078600160114     d #status                       25a   const
078700160114
078800160114      /free
078900160114
079000160114        @validRetStats = *on;
079100160114
079200160114        // do nothing if one of these status
079300160114        // if Other, then invalid
079400160114        select;
079500160114          when #status = 'created     ';
079600160114          when #status = 'inprogress  ';
079700160114          when #status = 'completed by merchant';
079800160114          other;
079900160114            @validRetStats = *off;
080000160114        endsl;
080100160114
080200160114        return @validRetStats;
080300160114
080400160114      /end-free
080500160114
080600160114     PValidReturnStatus...
080700160114     P                 E
080800160114
080900151125      /endif
081000140307
