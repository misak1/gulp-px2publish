<?php
/**
 * PX Commands "phpinfo"
 */
namespace picklesFramework2\commands;

/**
 * PX Commands "phpinfo"
 *
 * <dl>
 * 	<dt>PX=phpinfo</dt>
 * 		<dd>`phpinfo()` の実行結果を表示します。</dd>
 * </dl>
 */
class phpinfo{

	/**
	 * Picklesオブジェクト
	 */
	private $px;

	/**
	 * Starting function
	 * @param object $px Picklesオブジェクト
	 */
	public static function register( $px ){
		$px->pxcmd()->register('phpinfo', function($px){
			(new self( $px ))->kick();
			exit;
		}, true);
	}

	/**
	 * constructor
	 * @param object $px Picklesオブジェクト
	 */
	public function __construct( $px ){
		$this->px = $px;
	}


	/**
	 * kick
	 * @return void
	 */
	private function kick(){
		phpinfo();
		exit;
	}
}
