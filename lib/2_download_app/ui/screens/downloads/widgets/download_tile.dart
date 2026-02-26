import 'package:flutter/material.dart';
 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO
  Widget _buildIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return const Icon(Icons.download, size: 30);
      case DownloadStatus.downloading:
        return const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(strokeWidth: 3),
        );
      case DownloadStatus.downloaded:
        return const Icon(Icons.download_done, size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => controller.startDownload(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (controller.status != DownloadStatus.notDownloaded) ...[
                        const SizedBox(height: 4),
                        Text(
                          '${(controller.progress * 100).toStringAsFixed(1)} % completed'
                          ' - ${controller.downloadedSize.toStringAsFixed(1)}'
                          ' of ${controller.totalSize} MB',
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
                _buildIcon(controller.status),
              ],
            ),
          ),
        );
      },
    );
  }
}