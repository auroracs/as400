000100000000
000200151228     H Option(*NoDebugIO) bnddir('JETPROCS') DFTACTGRP(*no)
000300151127
000400151128      * to compile, use option 14.. no need to create module first.
000500151127
000600151228     D @cmpy           s              3a   inz('D  ')
000700160105     D @site           s              4a   inz('JTDO')
000800160104     D @orddate        s              8p 0 inz(01042016)
000900160104     D @whse           s              2p 0 inz(10)
001000160104     D @zip12          s             12a   inz('68137       ')
001100160104     D @state          s              2a   inz('NE')
001200151228     D @function       s             15a   inz('GETORDBYSTS ')
001300151228     D @ordstatus      s             15a   inz('Ready       ')
001400160114     D @retstatus      s             25a   inz('created     ')
001500151228     D @skustatus      s             30a   inz('Available for Purchase       ')
001600160104     D @sku            s             27a   inz('3614WHIT                   ')
001700151228     D @number         s              4a   inz(' 9 1')
001800160204     D @scanIN         s          30000a   inz('this is a {scanthis} pgm')
001900160106     D @scanValue      s            100a   inz('{scanthis}')
002000160106     D @replValue      s            100a   inz('sweet     ')
002100151228     d @value          s            500a   inz
002200151228     d @validSite      s               n   inz
002300151228     d @validFunction  s               n   inz
002400151228     d @validOrdStats  s               n   inz
002500160114     d @validRetStats  s               n   inz
002600151228     d @validSKUStats  s               n   inz
002700151228     d @validNumber    s               n   inz
002800151228     d returnURI       s            500a   inz
002900160106     d return500       s            500a   inz
003000160204     d return30000     s          30000a   inz
003100160104     d estDelDate      s             10a   inz
003200160104     d returnDays      s              3a   inz
003300160104     d returnASIN      s             20a   inz
003400160105     d returnCreds     s            150a   inz
003500151123
003600151228      /Define CopyJETPrototype
003700151228      /Copy QRPGLESRC,JETPROCS
003800151228      /UnDefine CopyJETPrototype
003900151127
004000151123      /free
004100151123
004200160215         if ValidSKU(@cmpy:'EBDO':@sku);
004300160215            dsply 'Valid sku';
004400160215         endif;
004500160215
004600160215         if not ValidSKU(@cmpy:@site:@sku);
004700160215            dsply 'invalid sku';
004800160215         endif;
004900160215
005000160114         if ValidReturnStatus(@retstatus);
005100160114            dsply 'Valid return status';
005200160114         endif;
005300160114
005400160107         return500 = BuildClassLib(@cmpy:@site);
005500160106
005600160204         return30000 = ScanReplace(@scanin:@scanvalue:@replvalue);
005700160107
005800160105         returnCreds = GetAPICreds(@cmpy:@site);
005900160104
006000160105         returnASIN = GetASINforSKU(@cmpy:@site:@site:@sku);
006100160105
006200160104         returnDays = GetReturnDays(@cmpy:@site);
006300160104
006400160104         estDelDate = GetEstDelDate(@cmpy:@whse:@zip12:@state:@orddate);
006500160104
006600151228         if ValidSite(@cmpy:@site);
006700151228            dsply 'Valid site';
006800151228         endif;
006900151127
007000151228         if ValidFunction(@cmpy:@site:@function);
007100151228            dsply 'Valid function';
007200151228         endif;
007300151228
007400151228         if ValidOrderStatus(@ordstatus);
007500151228            dsply 'Valid order status';
007600151228         endif;
007700151228
007800151228         if ValidSKUStatus(@skustatus);
007900151228            dsply 'Valid sku status';
008000151228         endif;
008100151228
008200151228         returnURI = GetAPIURI(@cmpy:@site:@function);
008300151128
008400151228         @value = UpperCase(returnURI);
008500151228
008600151228         @value = LowerCase(returnURI);
008700151228
008800151228         if ValidNumber(@number);
008900151228            dsply 'Valid number';
009000151228         endif;
009100151228
009200151228         if not ValidNumber('aaaa');
009300151228            dsply 'invalid number';
009400151228         endif;
009500151228
009600000000         *inlr = *on;
009700000000
009800000000      /end-free
