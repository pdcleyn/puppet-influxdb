# == Class: influxdb::params
# DO NOT DIRECTLY
class influxdb::params {
  $ensure                           =  'installed'
  $binding_address                  =  '0.0.0.0'
  $config_path                      =  '/opt/influxdb/shared/config.toml'

  # [logging]
  $logging_level                    =  'info'
  $logging_file                     =  '/opt/influxdb/shared/influxdb.log'

  # [admin]
  $admin_port                       =  '8083'
  $admin_assets                     =  '/opt/influxdb/current/admin'

  # [api]
  $api_port                         =  '8086'

  # [raft]
  $raft_port                        =  '8090'
  $raft_dir                         =  '/opt/influxdb/shared/data/raft'

  # [storage]
  $storage_dir                      =  '/opt/influxdb/shared/data/db'
  $storage_write_buffer_size        =  '10000'

  # [cluster]
  $cluster_protobuf_port            =  '8099'
  $cluster_protobuf_timeout         =  '2s'
  $cluster_protobuf_heartbeat       =  '200ms'
  $cluster_write_buffer_size        =  '10000'
  $cluster_query_shard_buffer_size  =  '1000'

  # [leveldb]
  $leveldb_max_open_files           =  '40'
  $leveldb_lru_cache_size           =  '200m'
  $leveldb_max_open_shards          =  '0'
  $leveldb_point_batch_size         =  '100'

  # [wal]
  $wal_dir                          =  '/opt/influxdb/shared/data/wal'
  $wal_flush_after                  =  '0'
  $wal_bookmark_after               =  '0'
  $wal_index_after                  =  '1000'
  $wal_requests_per_logfile         =  '10000'

  # package details
  case $::osfamily {
    'Debian': {
      $package_provider = 'dpkg'
      $package_source = $::architecture ? {
        /64/    => 'http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb',
        default => 'http://s3.amazonaws.com/influxdb/influxdb_latest_i386.deb',
      }
    }
    'RedHat', 'Amazon': {
      $package_provider = 'rpm'
      $package_source = $::architecture ? {
        /64/    => 'http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm',
        default => 'http://s3.amazonaws.com/influxdb/influxdb-latest-1.i686.rpm',
      }
    }
    default: {
      fail('Only supports Debian or RedHat $::osfamily')
    }
  }
}
