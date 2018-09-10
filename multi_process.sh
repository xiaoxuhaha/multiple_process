#!/usr/bin/env php
<?php
/** * PHP����̹���
 *
 */
date_default_timezone_set('PRC');
if (substr(php_sapi_name(), 0, 3) !== 'cli') {
    die("This program can only be run in CLI mode");
}
if (!function_exists('pcntl_fork')) {
    die("pcntl_fork not existing");
}
if (empty($argv[1])) {
    $man = <<<EOD
Usage: ./multi_process.sh <command> [max_process]
example:
    ./multi_process.sh "echo 'hello world!'" 30
EOD;
    exit($man);
}
// ����
$cmd = $argv[1];
// ��������
$max = isset($argv[2]) ? $argv[2] : 10;
for ($i = 0; $i < $max; $i++) {
    process_execute($cmd);
    readline_add_history($cmd); // ��ӵ���ʷ��¼
}
exit(0);
function process_execute($input) 
{
    $pid = pcntl_fork(); //�����ӽ���
    if ($pid == 0) {//�ӽ���
        $pid = posix_getpid();
        echo "\n*\x1b[5;34;m Process {$pid} was created, and Executed:\x1b[0m\n";
        echo exec($input); //ִ������
        echo "\n*\x1b[5;32;m Process {$pid} has finished running.\x1b[0m\n";
        exit;
    } else {//������
        $pid = pcntl_wait($status, WUNTRACED); //ȡ���ӽ��̽���״̬
        if (pcntl_wifexited($status)) {
                echo "\n\n* Sub process: {$pid} exited with {$status}";
        }
    }
}