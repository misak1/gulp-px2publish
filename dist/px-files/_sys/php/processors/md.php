<?php
/**
 * processor "*.md"
 */
namespace picklesFramework2\processors\md;

/**
 * processor "*.md" class
 */
class ext{

	/**
	 * 変換処理の実行
	 * @param object $px Picklesオブジェクト
	 */
	public static function exec( $px ){

		foreach( $px->bowl()->get_keys() as $key ){
			$src = $px->bowl()->pull( $key );

			if($key != 'head' && $key != 'foot'){
				$src = \Michelf\MarkdownExtra::defaultTransform($src);
			}

			$px->bowl()->replace( $src, $key );
		}

		return true;
	}
}
