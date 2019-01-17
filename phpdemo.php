<?php
    $ppid = posix_getpid();	
    $pid = pcntl_fork();
    if ($pid == -1) {
        throw new Exception('fork子进程失败!');
    } elseif ($pid > 0) {
        cli_set_process_title("我是父进程,我的进程id是{$ppid}.");
        sleep(30);
    } else {
        $cpid = posix_getpid();
        cli_set_process_title("我是{$ppid}的子进程,我的进程id是{$cpid}.");
        sleep(30);
    }	
?>