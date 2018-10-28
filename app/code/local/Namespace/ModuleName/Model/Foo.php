<?php

use Carbon\Carbon;

/**
 * @package    Namespace_ModuleName
 * @author     authorName <author@email.net>
 */
class Namespace_ModuleName_Model_Foo extends Mage_Core_Model_Abstract
{
    public function getCurrentDatetime()
    {
        return Carbon::now();
    }
}
